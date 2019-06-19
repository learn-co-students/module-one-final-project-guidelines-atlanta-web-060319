User.destroy_all
Goal.destroy_all
WaterIntake.destroy_all

brit = User.create(
  name: "Brit",
  age: 35,
  spirit_animal: "Fox"
)
tammy = User.create(
  name: "Tammy",
  age: 39,
  spirit_animal: "Wolf"
)
sulaimon = User.create(
  name: "Sulaimon",
  age: 30,
  spirit_animal: "Lion"
)

first = Goal.create(cup: 400)
second = Goal.create(cup: 600)
third = Goal.create(cup: 800)

one = WaterIntake.create(
  user_id: tammy.id,
  goal_id: third.id,
  tracker: 0
)
two = WaterIntake.create(
  user_id: sulaimon.id,
  goal_id: second.id,
  tracker: 0
)
three = WaterIntake.create(
  user_id: brit.id,
  goal_id: first.id,
  tracker: 0
)
