ActiveAdmin.register Match do
  permit_params :schedule

  index do
    selectable_column
    id_column
    column :team_a
    column :team_b
    column :score_a
    column :score_b
    column :schedule
    column :created_at
    actions
  end

  filter :team_a
  filter :team_b

  form do |f|
    f.inputs do
      f.input :schedule

    end
    f.actions
  end

end
