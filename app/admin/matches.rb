ActiveAdmin.register Match do
  permit_params :schedule, :final

  index do
    selectable_column
    id_column
    column :team_a
    column :team_b
    column :score_a
    column :score_b
    column :schedule
    column :created_at
    column :final
    actions
  end

  filter :team_a
  filter :team_b

  form do |f|
    f.inputs do
      f.input :schedule
      f.input :final

    end
    f.actions
  end

end
