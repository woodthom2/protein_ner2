# protein_ner
NER on protein texts

# Approach

I am using Tensorflow deep learning library with the SyntaxNet model which uses recurrent neural networks (RNNs) with a Long short-term memory (LSTM) architecture.
* SyntaxNet was originally developed for part of speech tagging, I've adapted it to named entity recognition.

# Requirements

* Ubuntu 14 or above (recommended, this may work on other Linux distros but will need adaptation for Mac and will probably not work on Windows)
* Python 2.7 (Anaconda recommended)
* Tensorflow 1.0: you can install via Anaconda or from source.
* Tensorflow Models: Clone https://github.com/tensorflow/models.git locally on your computer
* python -m pip install asciitree
* (for training) a GPU e.g. NVIDIA 1080

# Getting started

* Check out the Tensorflow Models repo and build the Syntaxnet parser (instructions from https://github.com/tensorflow/models/tree/master/syntaxnet, valid as of 17th February 2017 for version of Syntaxnet compatible with TensorFlow 0.12 and later):
```
git clone --recursive https://github.com/tensorflow/models.git

  cd models/syntaxnet/tensorflow
  
  ./configure
  
  cd ..
  
  bazel test syntaxnet/... util/utf8/...
```
* If there are no errors then Syntaxnet will be built correctly and you can train parser RNNs. If there are errors please refer to the Syntaxnet instructions: https://github.com/tensorflow/models/tree/master/syntaxnet
* Choose a data directory (ideally on a disk where you have lots of space) and set as an environment variable RNN_HOME (with trailing / because later on I will concatenate it)
* Set environment variable MODELS_DIR to where you cloned the Tensorflow Models repo (also with trailing /)

* mkdir $RNN_HOME/raw and put the three files from the task in here
* mkdir $RNN_HOME/preprocessed
* mkdir $RNN_HOME/data
* mkdir $RNN_HOME/train 
* mkdir $RNN_HOME/output 
* In folder rnn, execute Preprocess.ipynb. This will prepare the training data for a format that it can be used to train the RNN. It will also split off 10% as a validation set.
* Replace the absolute paths in context_protein.pbtxt with the appropriate ones for your system (pointing to $RNN_HOME).
* Copy context_protein.pbtxt to $MODELS_DIR/syntaxnet/syntaxnet/context_protein.pbtxt. (please note due to time constraints I have misused the slots for the 3 corpora in this context file: train=train, tuning=validation but dev=test)
* Execute tw_train_protein.sh
* The trained model will be saved in $RNN_DIR/train/brain_pos/greedy/.
* To execute the trained model on the training data, execute tw_run_protein_training_set.sh. The output will be saved to $RNN_DIR/train/brain_pos/greedy/128-0.08-3600-0.9-0/tagged-training-corpus.
* Likewise run the other sh files to run it on the validation or test set.
* Run GenerateOutputFile.ipynb to produce the final result for assessment. It will write a table showing the entities in the unseen test text to the output folder.
