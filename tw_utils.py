import unicodedata, re

'''
Define tokeniser that we will use for protein data.
Can't use normal NLP / NLTK tokeniser as it must be robust to strange punctuation that appears in biomed texts.
Splitting on Unicode general category.
'''
def tw_protein_tokenizer(sentence):
    tokens = []
    oldcat = None
    current_token = None
    for c in sentence: #re.sub("^\s+|\s+$", "", sentence):
        cat = unicodedata.category(unicode(c))
        if cat[0] == "L":
            cat = "L"
        if cat != oldcat:
            if current_token is not None:
                tokens.append(current_token)
            current_token = ''
        current_token += c
        if "Z" in cat:
            current_token = None
        oldcat = cat
    tokens.append(current_token)
    return tokens
