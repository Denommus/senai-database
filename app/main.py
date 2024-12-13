import pandas as pd
import MySQLdb as sql

def main():
    dataset = pd.read_csv("netflix_titles.csv", sep=",")
    for (index, row) in dataset.iterrows():
        print(row)

if __name__ == "__main__":
    main()
