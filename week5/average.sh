
#!/bin/bash
expr="scale=3;($1"
for value in "${@:2}"; do
	 expr=$expr+$value
done
expr+=")/$#"
echo $expr | bc

