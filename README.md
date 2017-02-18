# protein_ner
NER on protein texts

# Approaches

* RNNs (using TensorFlow syntaxnet)

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

* Choose a data directory (ideally on a disk where you have lots of space) and set as an environment variable RNN_HOME
* Set environment variable MODELS_DIR to where you cloned the Tensorflow Models repo.

* mkdir $RNN_HOME/raw and put the three files from the task in here
* mkdir $RNN_HOME/preprocessed
* mkdir $RNN_HOME/data
* mkdir $RNN_HOME/train 
* In folder rnn, execute Preprocess.ipynb. This will prepare the training data for a format that it can be used to train the RNN.
* In folder rnn, execute train_model.sh
* To execute the trained model, execute run_model.sh


