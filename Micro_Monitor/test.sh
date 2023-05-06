
#!/bin/bash

# Change the root password to "hello@alsco"
echo -e "hello@alsco\nhello@alsco" | passwd root

# Print a message indicating that the password has been changed
echo "The root password has been changed to: hello@alsco"
