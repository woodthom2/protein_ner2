export PROTEIN_NER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DATA_DIR=/tmp/protein_ner
mkdir $DATA_DIR
export MODELS_DIR=$PROTEIN_NER_DIR/models
