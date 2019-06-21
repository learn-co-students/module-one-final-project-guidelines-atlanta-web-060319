Description:

This Star Wars themed sandwich builder app lets the user login and build a sandwich. The ingredient types are bread, cheese, meat, greens and condiment. Each ingredient type has (at this release version) 3 options. Depending on the selection of cheese and meat, the app tells you what Star Wars sandwich name corresponds to the cheese/meat combination.

Users can edit or delete an order. Users can see the overall 3 most popular sandwiches, and of course, when the user is tired of building sandwiches, the user can exit the app. I hardcoded myself and Reina (Robert Chen and Reina Ewing) as the "admins", the "For Offical Business" option enters into a ruby session inside the app for development and bug testing purposes.

Install:

1. "bundle install" to get all the gems
2. "bundle exec rake db:migrate" to set up the database and tables
3. "bundle exec rake db:seed" to set up the sandwich names and their relationship with cheese/meat combinations. Also, it sets up two users, Robert Chen and Reina Ewing. The stuff in the sandwich table are not hardcoded into the program, so seeding is necessary.
4. "ruby bin/run.rb" to run the app.

Contributors(latest version contributed):
1. Reina Ewing (1.0 final)
2. Robert Chen (1.1)