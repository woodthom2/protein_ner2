cd $MODELS_DIR/syntaxnet
PARAMS=128-0.08-3600-0.9-0
bazel-bin/syntaxnet/parser_eval --task_context=$RNN_HOME/train/brain_pos/greedy/$PARAMS/context     --hidden_layer_sizes=128     --input=dev-corpus     --output=tagged-dev-corpus     --arg_prefix=brain_pos     --graph_builder=greedy     --model_path=$RNN_HOME/train/brain_pos/greedy/$PARAMS/model
