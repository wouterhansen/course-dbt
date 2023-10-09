# Week 1

## Metrics:

- **Total Users**: The total number of unique users registered on the platform.
- **Average Orders per Hour**: The average number of orders placed every hour.
- **Average Hours to Deliver**: On average, the number of hours it takes from an order being placed to being delivered.
- **Users by Purchase Count**: How many users have made one, two, or three or more purchases.
- **Average Sessions per Hour**: The average number of unique browsing sessions on the platform every hour.

## Results:

| Metric                          | Value      |
|---------------------------------|------------|
| Total Users                     | 130        |
| Average Orders per Hour         | 7.520      |
| Average Hours to Deliver        | 93.403     |
| Users with One Purchase         | 25         |
| Users with Two Purchases        | 28         |
| Users with Three+ Purchases     | 71         |
| Average Sessions per Hour       | 16.327     |

**Analysis can be seen here: https://github.com/FCdSP/course-dbt/blob/main/greenery/analyses/week_1_project.sql**

# Week 2

## Business objectives:

- **What is our user repeat rate?**: The ratio of users who made two or more purchases over total users.
- **Define good indicators for potential repeat users**
- **Define good indicators for potential non-repeat users**
- **What assumptions are you making about each model? (i.e. why are you adding each test?)**
- **Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**
- **How you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**
- **Which products had their inventory change from week 1 to week 2?**
  
## Results:

| Metric                          | Value      |
|---------------------------------|------------|
| Repeat rate                     | 79.84%     |

- **Define good indicators for potential repeat users**
  - **Number of itens on previous order**
  - **Usage of promo codes**
  - **Number of sessions until purchase**
  - **Average delivery time for the user**
  - **Good Reviews on the products**
  - **Good Reviews of the platform itself**

- **Define good indicators for potential non-repeat users**
  - **Type of product ordered (one-type purchases)**
  - **Email spam rate**
  - **Average delivery time for the user**
  - **Bad Reviews on the products**
  - **Bad Reviews of the platform itself**

- **What assumptions are you making about each model? (i.e. why are you adding each test?)**
  - **Since we are combining the data from staging layers, intermediate and fact/dimensions tables, we need to make sure we are linking (relationship to other tables) correclly. Also, make sure some variables aren't null, are unique etc**

- **Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**
  - **Yes, some tests are breaking, meaning we are going to have to go through what kind of erros (are there null values for variables that should always have values, are there negative values for where it shouldn't etc**

- **How you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**
  - **0. Set freshness tests in the sources.yml files** 
  - **1. Schedule the test to run at least daily, if not hourly for data pertaining the orders**
  - **2. Have (small) cerimonies to check the state of the data**
  - **3. If anything is breaking, automate messages to list the data that is incorrect and try to estimate an SLA to correct it**

- **Which products had their inventory change from week 1 to week 2?**
  - **String of Pearls: -48**
  - **Philodendron:     -26**
  - **Pothos:           -20**
  - **Monstera:         -13**

**Analysis can be seen here: https://github.com/FCdSP/course-dbt/blob/main/greenery/analyses/week_2_project.sql and https://github.com/FCdSP/course-dbt/blob/main/greenery/analyses/week_2_project_change_inventory.sql**

# Week 3

## Business objectives:

- **What is our overall conversion rate**: The ratio of products bought per day
- **What is our conversion rate by product?**: The ratio of each product bought per day
- **Why might certain products be converting at higher/lower rates than others? We don't actually have data to properly dig into this, but we can make some hypotheses**
- **We’re starting to think about granting permissions to our dbt models in our snowflake database so that other roles can have access to them**
- **Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project**
- **Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages**
- **Which products had their inventory change from week 2 to week 3?**

## Results:
- **What is our overall conversion rate?**
- **What is our conversion rate by product?**
  - **Analysis can be seen here: https://github.com/FCdSP/course-dbt/blob/main/greenery/analyses/week_3_project_overall_conversion_rate.sql and https://github.com/FCdSP/course-dbt/blob/main/greenery/analyses/week_3_project_product_conversion_rate.sql**
- **Why might certain products be converting at higher/lower rates than others? We don't actually have data to properly dig into this, but we can make some hypotheses**
  - **External factors: competitors might have cheaper options, faster delivery times, different payment options**
  - **Internal factors: product reviews, overall experience on the website, product description**
- **We’re starting to think about granting permissions to our dbt models in our snowflake database so that other roles can have access to them**
  - **A post-hook was added to a role called "reporting"**
- **Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project**
  - **dbt-utils was installed and used to check for null values in the tables. I also created an iterator for events and used it on the fact_product_funnel model**
- **Which products had their inventory change from week 2 to week 3?**
  - **ZZ Plant:         -36**
  - **Pothos:           -20**
  - **Monstera:         -14**
  - **Bamboo:           -12**
  - **Philodendron:     -10**
  - **String of pearls: -10**

# Week 4

## Business objectives:

- **Which products had their inventory change from week 3 to week 4?**
- **Which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks?**
- **How are our users moving through the product funnel?**
- **Which steps in the funnel have largest drop off points?**
- **If your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?**
- **If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?**
- **How would you go about setting up a production/scheduled dbt run of your project in an ideal state?**

## Results:
- **Which products had their inventory change from week 3 to week 4?**
```	postgresql
WITH change_inventory AS (

SELECT 

product_id
, name
, price
, inventory
, COALESCE(LAG(INVENTORY) OVER (PARTITION BY product_id ORDER BY dbt_updated_at),INVENTORY)  AS previous_inventory
, inventory - (COALESCE(LAG(INVENTORY) OVER (PARTITION BY product_id ORDER BY dbt_updated_at),INVENTORY)) AS change_in_inventory
, CASE WHEN (inventory - (COALESCE(LAG(INVENTORY) OVER (PARTITION BY product_id ORDER BY dbt_updated_at),INVENTORY))) != 0 THEN 1 ELSE 0 END AS flag_change_in_inventory
, dbt_scd_id
, dbt_updated_at
, dbt_valid_from
, dbt_valid_to


FROM dev_db.dbt_fpetribufundthroughcom.products_snapshot
ORDER BY product_id, dbt_updated_at
)--change_inventory

SELECT 

    * 
    
FROM change_inventory 
WHERE flag_change_in_inventory = 1 
  AND dbt_valid_to IS NULL 
ORDER BY dbt_valid_from DESC, change_in_inventory
```
  - **Bamboo:           -21**
  - **Monstera:         -19**
  - **ZZ Plant:         -12**
  - **String of pearls:  10**
  - **Philodendron:      15**
  - **Pothos:            20**

- **Which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks?**
```	postgresql
SELECT 
  product_id
, name
, count(*) 
FROM dev_db.dbt_fpetribufundthroughcom.products_snapshot
GROUP BY 1,2
ORDER BY 3 DESC
```
- **The following products had at least 3 changes, all of the other ones had one change in inventory:**
  - **Pothos:            4**
  - **Philodendron:      4**
  - **Monstera:          4**
  - **String of pearls:  4**
  - **Bamboo:            3**
  - **ZZ Plant:          3**

```	postgresql
SELECT 

    *

FROM dev_db.dbt_fpetribufundthroughcom.products_snapshot
WHERE inventory = 0;
```
- **The following products went out of stock:**
  - **Pothos**
  - **String of pearls**

- **How are our users moving through the product funnel?**
```	postgresql
SELECT 

*

FROM dev_db.dbt_fpetribufundthroughcom.fact_product_funnel
GROUP BY ALL;
```
- **Looking at the products to adding them to the cart, the page_view_to_add_cart_rate, a little over 50% of users are accounted for. But from adding the product to the cart to actually buying them, the add_to_cart_to_checkout_rate, a little over 35% of the previous number will go through. Making the final conversion rate of about 19%**

- **Which steps in the funnel have largest drop off points?**
  - **Like most e-commerce, the largest drop is from adding products to the cart to checking out**

- **If your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?**
  - **The conjunction between faster experimenting with properly validated datasets, for the business team. The tool have an enormous appeal to data and analytics engineering teams. Focusing on tangible benefits, like bringing the speed of new project launches, would be a major incentive for the business teams**

- **How would you go about setting up a production/scheduled dbt run of your project in an ideal state?**
  - **Setting up the environments: following best practices, I would set a production environment as well as development environment, to have consistency in the development process**
  - **Organize the moving parts: having an orchestrator, like Airflow or Dagster, to organize the scheduling and to help monitor the runs**
  - **Scheduling: Define the schedule you would need, for each layor of data**
  - **Metadata and logs: capturing data about the runs itself will help monitor the analytics engineering layor, like duration, the changes in each table, status of the runs itself**
  - **Monitoring: using the metadata monitor to setup rerun on critical data, separating fail runs from errors and alerting the proper teams**