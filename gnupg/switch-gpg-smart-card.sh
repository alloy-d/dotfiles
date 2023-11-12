#!/bin/bash
set -uexo pipefail

GNUPGHOME=${GNUPGHOME-"${HOME}/.gnupg"}
OPERATION="${1-}"
CARD="${2-NFC}"
KEYGRIPS="AA834B25B3B0F86AE7D7AD04C17C60EBA883461B 8DF7BE7931EB269AD310EBD70817BA7DC310ABFD 8F001E2055E5D202AB32A7D3216499FF133331AE"

KEY_DIR="${GNUPGHOME}/private-keys-v1.d"

usage() {
  set +x
  echo "This is a utility for managing key stubs used by GPG."
  echo "It is useful when using the same keys with multiple smart cards."
  echo
  echo "Usage: ${0} operation [card]"
  echo
  echo "Examples:"
  echo
  echo "  ${0} clear"
  echo "      clears cached key stubs"
  echo
  echo "  ${0} save NFC"
  echo "      saves the current key stubs to name 'NFC'"
  echo
  echo "  ${0} restore NFC"
  echo "      restores the key stubs with name 'NFC'"
  echo
}

if [ "${OPERATION:-empty}" = "empty" ]; then
  usage
  exit 1
fi

validate_card() {
  if [[ ("$CARD" != "nano") && ("$CARD" != "NFC") && ("$CARD" != "5C-NFC") && ("$CARD" != "5C-nano")]]; then
    echo "Sorry, never heard of card ${CARD}."
    exit 1
  fi
}

if [ "${OPERATION}" = "clear" ]; then
  for grip in $KEYGRIPS; do
    rm "${KEY_DIR}/${grip}.key"
  done
elif [ "${OPERATION}" = "save" ]; then
  validate_card
  echo "Saving cached keys for ${CARD}..."
  for grip in $KEYGRIPS; do
    cp "${KEY_DIR}/${grip}.key" "${KEY_DIR}/${grip}.key.${CARD}"
  done
elif [ "${OPERATION}" = "restore" ]; then
  validate_card
  echo "Restoring cached keys for $CARD..."
  for grip in $KEYGRIPS; do
    cp "${KEY_DIR}/${grip}.key.${CARD}" "${KEY_DIR}/${grip}.key"
  done
else
  echo "I don't know how to do operation '${OPERATION}'."
fi
