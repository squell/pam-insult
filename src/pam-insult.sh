#! /bin/bash
#
# Usage: pam-insult.sh [delay]
#
# The delay provided causes pam-insult to annoy the user further by letting them wait. This can also be used to ensure that
# any insult is clearly visible in something like GNOME Display Manager.

# shell script should fail if any of the unchecked commands fail
set -e

#       The child's environment is set to the current PAM environment list, as returned by pam_getenvlist(3) In addition,
#       the following PAM items are exported as environment variables: PAM_RHOST, PAM_RUSER, PAM_SERVICE, PAM_TTY, PAM_USER
#       and PAM_TYPE, which contains one of the module types: account, auth, password, open_session and close_session.
#
#       Commands called by pam_exec need to be aware of that the user can have control over the environment.

# fail if this module is used as anything other than an account PAM
test "$PAM_TYPE" = auth

# insult the user
declare -a insults
insults=(
    "Well, well, well... look who's all thumbs at the keyboard."
    "I see someone's been taking typing lessons from a sloth."
    "Guess what? Wrong password again! Your password game is weaker than a newborn kitten."
    "You must have fingers made of butter, because that password slipped right through."
    "Congratulations! You've just won the 'Most Consistent Incorrect Password Entry' award."
    "Did you forget your password or just your brain?"
    "At this rate, you'll crack the code just in time for the next millennium."
    "If passwords were wishes, you'd still be out of luck."
    "Is that your password or a desperate cry for help?"
    "You're like a broken record, but instead of music, it's the sound of failure."
)

n=$(($RANDOM % ${#insults[@]}))
echo "${insults[n]}"

# optional: make the user wait
test "$1" && sleep "$1"

false
