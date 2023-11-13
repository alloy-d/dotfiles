# ADAM'S DEFINITIVE SSH_AUTH_SOCK REFERENCE
# because he's been confused for years
#
# It might be set by...
# 1. SSH, when using agent forwarding
# 2. PAM on Linux, configured through ~/.pam_environment
# 3. macOS
# 4. Some shell (see below!)
#
# Do we want each of those?
# 1. Yes yes absolutely, top priority
# 2. Yes this is fine
# 3. No no definitely not! Never!
# 4. Yes this is fine
#
# In other words, we don't want to blindly set SSH_AUTH_SOCK all the
# time, because we don't want to override a forwarded SSH agent.
# However, we also can't assume any setting is correct, becuase we don't
# want the macOS default.
#
# Therefore, we want to identify the macOS default and crush it, but
# leave everything else alone.

if command -q gpg-agent; and command -q gpg-connect-agent
  if string match -q "*com.apple.launchd*" "$SSH_AUTH_SOCK"
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end

  # This is for the odd case where you're not using a pinentry GUI.
  # We have to tell GPG what terminal we're on, otherwise it won't be able
  # to find us to ask for a PIN.
  set -x GPG_TTY (tty)
  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye > /dev/null
end
