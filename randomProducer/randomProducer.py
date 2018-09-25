import datetime
import pandas as pd
import numpy as np

def time(year, month):
    day = np.random.randint(1, 7)
    while True:
        try:
            hour = abs(int(np.random.normal(12, 11)))
            minute = abs(int(np.random.normal(30, 29)))
            second = abs(int(np.random.normal(30, 29)))
            date = datetime.datetime(year, month, day, hour, minute, second)
            break
        except ValueError:
            pass
    return str(date)

def octet():
    return str(np.random.randint(1, 232))

def randomIP():
    return octet() + '.' + octet() + '.' + octet() + '.' + octet()

def randomRowDataFrame(dataset, year, month):
    randomNumber = np.random.randint(0, len(dataset))
    productName = dataset["Product"][randomNumber]
    productCategory = dataset["Product type"][randomNumber]
    productPrice = abs(round(np.random.normal(500, 300), 2))
    purchaseDate = time(year, month)
    clientIPAddress = randomIP()

    # dict1 = {'product name': productName, 'product price': productPrice, 'purchase date': purchaseDate,
    #          'product category': productCategory, 'client IP address': clientIPAddress}
    dict1 = ",".join(map(str, [purchaseDate, productName, productPrice, productCategory, clientIPAddress]))
    return dict1

def dataForDataFrame(dataset, year, month):
    for i in range(3000):
        print(randomRowDataFrame(dataset, year, month))

def main():
    dataset = pd.read_csv('dataset.csv')

    year = np.random.randint(2010, 2017)
    month = np.random.randint(1, 12)

    dataForDataFrame(dataset, year, month)

main()

