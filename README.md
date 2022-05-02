# Project Proposal
Group B-2: Daniella Tsing, Eugene Kim, Brandon Nguyen, Roberto Raftery

## Domain of Interest
In this section, you'll identify a domain that you are interested in (e.g., music, education, dance, immigration -- any field of your interest) and answer the following questions in your README.md file:

Why are you interested in this field/domain?

- We are interested in the field of healthcare as most of us are going into a career related to or in healthcare and want to learn more about the statistics and data that surrounds a prevalent topic in healthcare, which is cancer.

What other examples of data driven project have you found related to this domain (share at least 3)?

1. One example of a data driven project related to the field of healthcare, and more specifically, cancer, is a blog post written titled "How may people in the world die from cancer?" The blog post utilizes the data set "total-cancer-deaths-by-type.csv", by displaying an overview of cancer deaths by type, age, and death rates from a global perspective, to depict the growth of cancer deaths and their incidences.
2. The National Cancer Institute uses the data set "DowloadableDataFull_2011.01.12.csv", to estimate the amount of expenses spent for cancer care in 2010 and 2020 at a national level. The data also takes survival, incidence, type of cancer, phase of care, and stage at diagnosis into consideration to create a trend. This data is used as a resource to provide estimates for those who are looking to cancer care.
3. A user on GitHub created a [project](https://github.com/medtorch/awesome-healthcare-ai) in which they curated a list of open source healthcare tools, machine learning algorithms, datasets and research papers and categorized them by medical specialties, medical tasks, and medical privacy. The data sets compiled in this project are sorted within the medical specialties and can be used as a resource.

What data-driven questions do you hope to answer about this domain (share at least 3)?

- We hope to understand:
    1. What location is involved with the most cancer deaths?
    2. What form of cancer has caused the most deaths?
    3. What is the difference in the mean and median year for cancer deaths in a given location?

## Finding Data
We are lucky enough to live in a time when there is lots of publicly available data made possible by governments, journalists, academics, and companies. In this section, you will **identify and download** at least 3 sources of data related to your domain of interest described above (into a folder you create called data/). You won't be required to use all of these sources, but it will give you practice discovering data. If your data is made available through a Web API, you don't need to download it. For each source of data, provide the following information:

Where did you download the data (e.g., a web URL)?

 - Each data set was downloaded from [kaggle](https://www.kaggle.com/datasets).

How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?

 1. For the [Costs for Cancer Treatment](https://www.kaggle.com/datasets/rishidamarla/costs-for-cancer-treatment) data set, the data was collected by the National Cancer Institute (NCI). The data is about cancer patients and how much they spend on cancer treatment in total, during their initial year, and during their last year of life. The data also shows the annual cost increase of treatment. It is not known how the data was collected.
 2. For the [Cancer Death Rates in the World 1990-2019](https://www.kaggle.com/datasets/bahadirumutiscimen/cancer-death-rates-in-the-world-19902019) data set, the data is computed and organized based on estimates from the IHME's Global Burden of Disease Programme. The data is concerned with the deaths due to cancer and considers type, age, and death rates to assess incidence and survival rates.
 3. For the [Cancer Deaths in US States & Counties](https://www.kaggle.com/datasets/rishidamarla/cancer-deaths-in-us-states-counties) data set, the data was collected by Darmouth Atlas and it is about the number of people who die from cancer, get admitted to the hospital due to cancer, spend time in the hospital due to their cancer, get admitted to a hospice, and receiving life-sustaining treatment. The data was collected from hospitals by the Dartmouth Institute for the Dartmouth Atlas Project

How many observations (rows) are in your data?

 1. There are 1258 rows for the [Costs for Cancer Treatment](https://www.kaggle.com/datasets/rishidamarla/costs-for-cancer-treatment) data set.
 2. There are 8011 rows for the [Cancer Death Rates in the World 1990-2019](https://www.kaggle.com/datasets/bahadirumutiscimen/cancer-death-rates-in-the-world-19902019) data set.
 3. There are 308 rows for the [Cancer Deaths in US States & Counties](https://www.kaggle.com/datasets/rishidamarla/cancer-deaths-in-us-states-counties) data set.

How many features (columns) are in the data?

 1. There are 9 columns for the [Costs for Cancer Treatment](https://www.kaggle.com/datasets/rishidamarla/costs-for-cancer-treatment) data set.
 2. There are 32 columns for the [Cancer Death Rates in the World 1990-2019](https://www.kaggle.com/datasets/bahadirumutiscimen/cancer-death-rates-in-the-world-19902019) data set.
 3. There are 34 columns for the [Cancer Deaths in US States & Counties](https://www.kaggle.com/datasets/rishidamarla/cancer-deaths-in-us-states-counties) data set.

What questions (from above) can be answered using the data in this dataset?

1. [Costs for Cancer Treatment](https://www.kaggle.com/datasets/rishidamarla/costs-for-cancer-treatment) does not answer any of the questions from above, but it does answer questions such as: what type of cancer is the most expensive to treat? what type of cancer is more common in males/females? what type of cancer results in the highest expenditure during a patient's last year of life?
2. [Cancer Death Rates in the World 1990-2019](https://www.kaggle.com/datasets/bahadirumutiscimen/cancer-death-rates-in-the-world-19902019) is able to answer all of the questions from above.
3. [Cancer Deaths in US States & Counties](https://www.kaggle.com/datasets/rishidamarla/cancer-deaths-in-us-states-counties) is able to answer all of the questions from above.
