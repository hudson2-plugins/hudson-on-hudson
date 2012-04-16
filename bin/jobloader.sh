
OUTPUT_DIR=$BASE_DIR/target
TEMPLATES=$BASE_DIR/templates
CLASSPATH=$BASE_DIR/lib/hudson-cli.jar:$BASE_DIR/lib/jobcreator.jar:$BASE_DIR/lib/jython.jar

rm -rf $OUTPUT_DIR
mkdir $OUTPUT_DIR
echo $CLASSPATH
java -cp $CLASSPATH org.python.util.jython ./jobLoader.py $1 $2 $3 $4
