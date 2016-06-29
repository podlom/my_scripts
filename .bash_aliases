#
alias composer='/usr/bin/php /home/taras/bin/composer.phar'
#
# alias ssh_dev='ssh -p 2212 taras@ssh-host-shkodenko.com'
alias ssh_dev='ssh taras@ssh-host-shkodenko.com'
#
# alias mysql_setup_tonnel='ssh taras@ssh-host-shkodenko.com -L 127.0.0.1:3307:mysql-host-shkodenko.com:3306 -A'
# Create the SSH tunnel manually
# The syntax for creating the SSH tunnel is ssh -L [local port]:[database host]:[remote port] \
# [username]@[remote host]
alias mysql_setup_tonnel='ssh -L 3307:mysql-host-shkodenko.com:3306 taras@ssh-host-shkodenko.com -A'
#
alias mount_sand_htdocs='/home/taras/my_scripts/mount_sand_htdocs.sh'
alias deploy2cms='/home/taras/my_scripts/deploy_cms.sh'
#
alias phpcf='/home/taras/bin/phpcf/phpcf'
#
alias rnd_pass='/usr/bin/php /home/taras/my_scripts/get_random_password.php'
alias rand_pass='/usr/bin/php /home/taras/my_scripts/get_random_password.php'
#
alias git_sand_co_rel="ssh taras@ssh-host-shkodenko.com 'cd /home/taras/public_html && pwd && git checkout rel && git status'"
alias git_co_branch='/home/taras/my_scripts/git_co_branch.sh'
#
alias xdebug_sand='ssh -R 9898:127.0.0.1:9898 taras@ssh-host-shkodenko.com -p 2212'
#
alias screen='/home/taras/my_scripts/screen_local.sh'
