defmodule FlamesRepo.Migrations.AddFlames do
    use Ecto.Migration
  
    def change do
      create table(:errors) do
        add :message, :text
        add :level, :string
        add :timestamp, :naive_datetime
        add :alive, :boolean
        add :module, :string
        add :function, :string
        add :file, :string
        add :line, :integer
        add :count, :integer
        add :hash, :string
        add :resolved, :string
  
        add :incidents, Flames.Error.Incident
  
        timestamps()
      end
  
      create index(:errors, [:hash])
      create index(:errors, [:updated_at])
    end
  end