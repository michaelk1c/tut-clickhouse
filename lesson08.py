# https://clickhouse.com/blog/querying-pandas-dataframes

import chdb.dataframe as cdf
import pandas as pd


def main():
    house_prices = pd.read_csv(
        filepath_or_buffer="data/HouseListings-Top45Cities-10292023-kaggle.csv",
        encoding="ISO-8859-1",
    )

    print(house_prices.head(n=2).T)

    cities = pd.read_csv(filepath_or_buffer="data/canadacities.csv")
    print(cities.head(n=1).T)

    top_cities = cdf.query(
        house_prices=house_prices,
        cities=cities,
        sql="""
            FROM __house_prices__ AS hp
            JOIN __cities__ AS c 
            ON c.city_ascii = hp.City AND c.province_name = hp.Province
            SELECT City, Province, count(*),
                round(avg(Price)) AS avgPrice,
                round(max(Price)) AS maxPrice,
                ranking, density
            GROUP BY ALL
            LIMIT 10
            """,
    )

    top_cities.query(
        """
        FROM __table__ 
        SELECT City, maxPrice, ranking, density 
        LIMIT 5
        """
    )

    top_cities_df = top_cities.to_pandas()
    print(top_cities_df.head(n=1).T)
    print(top_cities_df)

    bc_top_cities = (
        top_cities_df[top_cities_df["Province"] == "British Columbia"]
        .sort_values(["ranking", "density"])
        .drop(["Province"], axis=1)
    )
    print("aaa=====")
    print(top_cities_df)
    print("bbb=====")
    print(bc_top_cities)


if __name__ == "__main__":
    main()
