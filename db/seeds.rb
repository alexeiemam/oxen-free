# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

article_seed_file = Rails.root.join(*%w(db seeds articles.json))
# File.open(article_seed_file, 'w') { |file| file.write(JSON.pretty_generate(Article.all.map{|j|j.attributes.except('id')})) }

Article.create!(JSON.load_file(article_seed_file))
