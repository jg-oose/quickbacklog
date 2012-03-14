# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Project.create(name: "Dein naechstes Projekt!",
  vision: "Beschreib die Essenz Deines Projekt in wenigen Worten ... Template",
  size_scale: {
    "0" => 0, "1" => 1, "2" => 2, "3" => 3, "5" => 5,
    "8" => 8, "13" => 13, "21" => 21, "40" => 40, "100" => 100},
  entry_template_text: "_Story_\n...\n\n_Howto Demo_\n...\n\n_Value_\n...\n\n_Risks_\n...\n\n_What else you need_...")
