Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


Qs week 2


Q1: What is our user repeat rate? Repeat Rate = Users who purchased 2 or more times / users who purchased. 79%
Q2:
What are good indicators of a user who will likely purchase again? 
        - Repeating orders 
        - Used promo, came back after?
        - Order being complete 
        - How often does the user come to the site 
        - Consumer behaviour: 
            - clicking around to spent money
            - goal focussed (limited clicks)
What about indicators of users who are likely not to purchase again? 
        - Incomplete orders / returns 
        - Late delivery —> date diff created vs delivered 
        - Estimate vs actual delivery 

Q3: Explain the product mart models you added. Why did you organize the models in the way you did?
- Repeat rate
- Accurateness of delivery 
    - early/on time/promised delivery moment = good customer experience
    - way to late = negative experience, less likely to see consumer again: bad customer experience





Part 2: Tests
Part 2: Q1 What assumptions are you making about each model?
Just play with it and go with the flow, put some ops insights into it
Part 2: Q2 Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- Already got that part out in the stsaging queries. 

Part 3: Inventory changes 
- 
