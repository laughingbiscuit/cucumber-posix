# Set the shebang and opts
printf "#!/bin/sh\nset -e\n"

# Define our custom step processing
function custom_step (){
  sed -e "s/\s*\($1\)/\n## \1\n$2/"
} 

# Tidy up lines with no definition
sed  "/^$/d"			|\
sed -e "s/.*Feature:\(.*\)/# Feature:\1/"		|\
sed -e "s/.*Scenario:\(.*\)/\n# Scenario:\1/"		|\

# Specify our custom step definitions
custom_step "Given I set a variable" "export A=B"	|\
custom_step "When I list files" "ls"			|\
custom_step "When I do something random" "ls"		|\
custom_step "Then I receive success" "[ $? -eq 0 ]"	|\
custom_step "Then I receive failure" "[ $? -ne 0 ]"

# Done
echo "echo \"Tests complete.\""
