# Anaconda conda: conda create -n presidio python=3.10 anaconda
# conda activate presidio
# pip install spacy==3.4.4
# pip install phonenumbers==8.12
# python -m spacy download en_core_web_lg

from presidio_analyzer import AnalyzerEngine

text="My phone number is 212-555-5555, https://asfas.com"

# Set up the engine, loads the NLP module (spaCy model by default) 
# and other PII recognizers
analyzer = AnalyzerEngine()

supported_entities = ["CREDIT_CARD", "CRYPTO", "DATE_TIME",\
    "EMAIL_ADDRESS", "IBAN_CODE", "IP_ADDRESS", "NRP", "LOCATION",\
        "PERSON", "PHONE_NUMBER", "MEDICAL_LICENSE", "URL"]

# Call analyzer to get results
results = analyzer.analyze(text=text,
                           entities=supported_entities,
                           language='en')

print(results)
