# Fastrcart Fee Calculator

Welcome to your first day as a software dev at e-commerce giant Fastrcart! You've been tasked with adding a new feature to their FeeCalculator class, which computes the fees to be charged on a list of purchased items.

Currently, handling fees are charged at a flat rate of $1 per item shipped. There are additional fees for items over $100, and on items that weigh more than 10 pounds.

However, certain items may have had the extra fees for weight or price waived. The waived fees are passed as an array of Discount objects to the FeeCalculator.

Your task is to create a new type of Discount that reduces an item's fees by half. To make this task easier, there is a failing integration test already written for you.
