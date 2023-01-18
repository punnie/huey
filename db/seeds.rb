# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RssFeed.create([
                 { title: 'SÁBADO', uri: 'https://www.sabado.pt/rss' },
                 { title: 'Expresso', uri: 'http://feeds.feedburner.com/expresso-geral' },
                 { title: 'Observador', uri: 'https://feeds.feedburner.com/obs-ultimas' },
                 { title: 'PÚBLICO', uri: 'http://feeds.feedburner.com/PublicoRSS' },
                 { title: 'ECO', uri: 'https://eco.sapo.pt/rss' },
                 { title: 'Jornal de Notícias - Últimas Notícias', uri: 'http://feeds.jn.pt/JN-Ultimas' },
                 { title: 'Jornal de Negócios', uri: 'https://www.jornaldenegocios.pt/rss' }
               ])

SitemapFeed.create(
  { title: 'Diário de Notícias', uri: 'https://www.dn.pt/sitemap.xml' }
)
