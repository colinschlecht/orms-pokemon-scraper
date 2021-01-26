require 'pry'
class Pokemon
    attr_accessor :name, :type, :db, :id
    def initialize(db)
        @id = db[:id]
        @name = db[:name]
        @type = db[:type]
        @db = db
    end
    def self.update(name, type, db)
        sql = <<-SQL
        UPDATE pokemon SET name = ?, type = ?, db = ? WHERE ID = ?
        SQL
        db.exectue(sql, name, type, db)
    end
    def self.save(name, type, db)
            sql =<<-SQL
            INSERT INTO pokemon (name, type)
            values (?, ?)
            SQL
            db.execute(sql, name, type)
            @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL
        poke = db.execute(sql, id).flatten
        new_pokemon = Pokemon.new(id: poke[0], name: poke[1], type: poke[2])
        
    end
end
