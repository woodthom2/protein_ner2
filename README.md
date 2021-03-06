# protein_ner
NER on protein texts.

By Thomas Wood, https://www.fastdatascience.com

# Important note

When evaluating the output of my Named Entity tagger, please note the character indices produced by the output of this program may not entirely be as expected if you are using a gold standard generated on Windows, I think this is due to encoding issues or Linux/Windows line break differences. This doesn't affect the entities identified.

# Approach

I am using Tensorflow deep learning library with the SyntaxNet model which uses recurrent neural networks (RNNs) with a Long short-term memory (LSTM) architecture.
* SyntaxNet was originally developed for part of speech tagging, I've adapted it to named entity recognition.

# Requirements

* Ubuntu 14 or above (recommended, this may work on other Linux distros but will need adaptation for Mac and will probably not work on Windows)
* Python 2.7 (Anaconda recommended)
* Tensorflow 1.0: you can install via Anaconda or from source.
* Tensorflow Models: Clone https://github.com/tensorflow/models.git locally on your computer
* python -m pip install asciitree
* (for training) a GPU e.g. NVIDIA 1080 but this is not essential, you can easily run TensorFlow on CPU

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
* mkdir $RNN_HOME/validation
* In folder rnn, execute the two Preprocess_*.ipynb notebooks. This will prepare the training and test data for a format that it can be used to train the RNN. It will also split off 10% from the training set as a validation set.
* Replace the absolute paths in context_protein.pbtxt with the appropriate ones for your system (pointing to $RNN_HOME).
* Copy context_protein.pbtxt to $MODELS_DIR/syntaxnet/syntaxnet/context_protein.pbtxt. (please note due to time constraints I have misused the slots for the 3 corpora in this context file: train=train, tuning=validation but dev=test)
* Execute tw_train_protein.sh
* The trained model will be saved in $RNN_DIR/train/brain_pos/greedy/.
* To execute the trained model on the training data, execute tw_run_protein_training_set.sh. The output will be saved to $RNN_DIR/train/brain_pos/greedy/128-0.08-3600-0.9-0/tagged-training-corpus.
* Likewise run the other sh files to run it on the validation or test set.
* Run GenerateOutputFile.ipynb to produce the final result for assessment. It will write a table showing the entities in the unseen test text to the output folder.
* To validate the model on the 10% of the training set, run RunValidation.ipynb


# Running my trained model

If you want to run the model that I trained earlier, copy the trained folder from tw_rnn_home into your RNN_HOME folder and run tw_run_protein*.sh as normal. You will need to change all the absolute paths inside $RNN_HOME/train/brain_pos/greedy/128-0.08-3600-0.9-0/context to point to the correct location on your system too.

# Notes on the code

There are a lot of ways I would have preferred to refactor this code but I was unable to do so due to limited time.

1. Use a submodule for the TensorFlow Models dependencies
2. Link the Python code together properly instead of using shell scripts, Ipython Notebooks and environment variables
3. Clean up the preprocessing code so it's more unified, as logic is duplicated
4. On my system (Ubuntu) the character indices of the training corpus didn't align correctly with the text - they were often off by one to the left and right so I had to code a little hack to identify these cases and shift my indices accordingly. I think this is because of either encoding issues or line breaks (Windows vs Linux) so I would clean this up and do it properly.
5. My tokenisation methods are not very good as I am tokenising text and then throwing away character indices which would have been useful later.
6. My validation dataset is too easy, as I have split on sentence level and not document level, so it's possible that some sentences from a given document end up in my training set and some end up in my validation set, making the validation task deceptively easy.
