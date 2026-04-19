We had deployed a multi component app in k8s this is a voting application where we vote between cat vs dog will show.

Conainer we created;
1. redis -> As in memory database
2. postgres -> As a perstiant DB
3. worker -> To store data from redis to postgress
4. voting-app -> The UI of the application
5. voting result -> The result of the votes
