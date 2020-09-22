#Prep
SPACE_LEFT=$(df -h | grep '/$' | awk '{print $4, "/" $2}')

#Output

echo "$SPACE_LEFT"
