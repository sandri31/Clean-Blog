class AddInitialCategories < ActiveRecord::Migration[7.0]
  def up
    Category.create(name: "Dev")
    Category.create(name: "Astuces")
    Category.create(name: "DevOps")
    Category.create(name: "Concepts de base")
    Category.create(name: "Bonne pratiques")
    Category.create(name: "Résolution de problèmes")
    Category.create(name: "Projets")
    Category.create(name: "Comparaisons et revues")
    Category.create(name: "Tutoriel")
  end

  def down
    Category.where(name: ["Dev", "Astuces", "DevOps", "Concepts de base", "Bonne pratiques", "Résolution de problèmes", "Projets", "Comparaisons et revues", "Tutoriel"]).destroy_all
  end
end
