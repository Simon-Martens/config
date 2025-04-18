#!/bin/sh

commit() {
	if [ -z "$(git status -s -uno | grep -v '^ ' | awk '{print $2}')" ]; then
		gum confirm "Stage all?" && git add .
	fi	

	if [ -z "$(git status -s -uno | grep -v '^ ' | awk '{print $2}')" ]; then
		echo '{{ Bold (Color "99" "0" "No files in index\n") }}' | gum format -t template
		return
	fi

	TYPE=$(gum choose "BUGFIX" "FEAT" "DOCS" "STYLE" "REFACTOR" "TEST" "DEPS" "REVERT" "CHORE" "DATA" --header "Commit Type")
	SCOPE=$(gum input --placeholder "Commit Scope")

	# Since the scope is optional, wrap it in parentheses if it has a value.
	test -n "$SCOPE" && SCOPE="($SCOPE) "

	# Pre-populate the input with the type(scope): so that the user may change it
	SUMMARY=$(gum input --value "$TYPE $SCOPE" --placeholder "Summary of this change")

	FILES="$(git status -s -uno)"

	echo '{{ Bold "Files" }} \n $(echo $FILES) \n \n {{ Bold "Message" }} \n $(echo $SUMMARY) \n'

	# Commit these changes if user confirms
	gum confirm "Commit changes?" && git commit -m "$SUMMARY" 
}
