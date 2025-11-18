-- Techlingo Seed Data
-- Consolidated initial data with full language support

-- ====================================
-- LANGUAGES (must be inserted first!)
-- ====================================
INSERT INTO languages (code, name, native_name, flag, is_active, display_order) VALUES
('sk', 'Slovak', 'Slovenčina', '🇸🇰', true, 1),
('en', 'English', 'English', '🇬🇧', true, 2),
('de', 'German', 'Deutsch', '🇩🇪', true, 3),
('cz', 'Czech', 'Čeština', '🇨🇿', true, 4);

-- ====================================
-- USERS
-- ====================================
INSERT INTO users (email, password, name, role, created_at, updated_at) VALUES
('admin@techlingo.sk', 'admin123', 'Admin User', 'ADMIN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('user@techlingo.sk', 'user123', 'Regular User', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ====================================
-- CATEGORIES (keys only)
-- ====================================
INSERT INTO categories (key) VALUES
('material'),
('statics'),
('structure'),
('finishing'),
('energy'),
('hvac'),
('other');

-- ====================================
-- CATEGORY TRANSLATIONS
-- ====================================

-- Slovak translations
INSERT INTO category_translations (category_id, language, name, description) VALUES
((SELECT id FROM categories WHERE key = 'material'), 'sk', 'Materiály', 'Stavebné materiály a prvky'),
((SELECT id FROM categories WHERE key = 'statics'), 'sk', 'Statika', 'Statické výpočty a konštrukcie'),
((SELECT id FROM categories WHERE key = 'structure'), 'sk', 'Konštrukcie', 'Stavebné konštrukcie'),
((SELECT id FROM categories WHERE key = 'finishing'), 'sk', 'Povrchové úpravy', 'Dokončovacie a povrchové úpravy'),
((SELECT id FROM categories WHERE key = 'energy'), 'sk', 'Energia', 'Energetická efektívnosť a úspory'),
((SELECT id FROM categories WHERE key = 'hvac'), 'sk', 'Vzduchotechnika', 'Vykurovanie, vetranie a klimatizácia'),
((SELECT id FROM categories WHERE key = 'other'), 'sk', 'Ostatné', 'Ostatné stavebné termíny');

-- English translations
INSERT INTO category_translations (category_id, language, name, description) VALUES
((SELECT id FROM categories WHERE key = 'material'), 'en', 'Materials', 'Building materials and elements'),
((SELECT id FROM categories WHERE key = 'statics'), 'en', 'Statics', 'Static calculations and structures'),
((SELECT id FROM categories WHERE key = 'structure'), 'en', 'Structures', 'Building structures'),
((SELECT id FROM categories WHERE key = 'finishing'), 'en', 'Finishing', 'Finishing and surface treatments'),
((SELECT id FROM categories WHERE key = 'energy'), 'en', 'Energy', 'Energy efficiency and savings'),
((SELECT id FROM categories WHERE key = 'hvac'), 'en', 'HVAC', 'Heating, ventilation and air conditioning'),
((SELECT id FROM categories WHERE key = 'other'), 'en', 'Other', 'Other construction terms');

-- German translations
INSERT INTO category_translations (category_id, language, name, description) VALUES
((SELECT id FROM categories WHERE key = 'material'), 'de', 'Materialien', 'Baustoffe und Materialien'),
((SELECT id FROM categories WHERE key = 'statics'), 'de', 'Statik', 'Tragwerksplanung und strukturelle Analyse'),
((SELECT id FROM categories WHERE key = 'structure'), 'de', 'Struktur', 'Gebäudestruktur und strukturelle Elemente'),
((SELECT id FROM categories WHERE key = 'finishing'), 'de', 'Ausbau', 'Innenausbau und Oberflächen'),
((SELECT id FROM categories WHERE key = 'energy'), 'de', 'Energie', 'Energieeffizienz und Nachhaltigkeit'),
((SELECT id FROM categories WHERE key = 'hvac'), 'de', 'HLK', 'Heizung, Lüftung und Klimatechnik'),
((SELECT id FROM categories WHERE key = 'other'), 'de', 'Sonstiges', 'Andere verwandte Begriffe');

-- Czech translations
INSERT INTO category_translations (category_id, language, name, description) VALUES
((SELECT id FROM categories WHERE key = 'material'), 'cz', 'Materiály', 'Stavební materiály'),
((SELECT id FROM categories WHERE key = 'statics'), 'cz', 'Statika', 'Statika staveb'),
((SELECT id FROM categories WHERE key = 'structure'), 'cz', 'Konstrukce', 'Konstrukce budov'),
((SELECT id FROM categories WHERE key = 'finishing'), 'cz', 'Dokončení', 'Dokončovací práce'),
((SELECT id FROM categories WHERE key = 'energy'), 'cz', 'Energie', 'Energetická účinnost'),
((SELECT id FROM categories WHERE key = 'hvac'), 'cz', 'HVAC', 'Vytápění, větrání a klimatizace'),
((SELECT id FROM categories WHERE key = 'other'), 'cz', 'Ostatní', 'Ostatní související termíny');

-- ====================================
-- TERMS (base info)
-- ====================================
INSERT INTO terms (slug, created_at, updated_at) VALUES
('zelezo-beton', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('tepelna-izolacia', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('nosna-stena', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('stresna-krytina', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('vzduchotechnika', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('zakladova-doska', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('omietka', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('energeticky-certifikat', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('tepelne-mosty', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('zaveterna-lista', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('podlahove-kurenie', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('parozabrana', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ====================================
-- TERM TRANSLATIONS
-- ====================================

-- Železobetón
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'zelezo-beton'), 'sk', 'Železobetón', 'Kompozit betónu a oceľovej výstuže prenášajúci tlak aj ťah.', 'Stropná doska bola navrhnutá ako železobetónová.'),
((SELECT id FROM terms WHERE slug = 'zelezo-beton'), 'en', 'Reinforced concrete', 'A composite of concrete and steel reinforcement that bears both compression and tension.', 'The ceiling slab was designed as reinforced concrete.');

-- Tepelná izolácia
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'tepelna-izolacia'), 'sk', 'Tepelná izolácia', 'Materiál znižujúci prestup tepla cez konštrukciu.', 'Fasáda bude zateplená minerálnou vlnou ako tepelnou izoláciou.'),
((SELECT id FROM terms WHERE slug = 'tepelna-izolacia'), 'en', 'Thermal insulation', 'Material that reduces heat transfer through a structure.', 'The facade will be insulated with mineral wool as thermal insulation.');

-- Nosná stena
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'nosna-stena'), 'sk', 'Nosná stena', 'Stena prenášajúca zvislé zaťaženie z vyšších podlaží.', 'Nosnú stenu nie je možné odstrániť bez statického posúdenia.'),
((SELECT id FROM terms WHERE slug = 'nosna-stena'), 'en', 'Load-bearing wall', 'Wall that transfers vertical loads from upper floors.', 'The load-bearing wall cannot be removed without structural assessment.');

-- Strešná krytina
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'stresna-krytina'), 'sk', 'Strešná krytina', 'Povrchová vrstva strechy chrániacа pred poveternostnými vplyvmi.', 'Ako strešnú krytinu sme zvolili keramickú škridlu.'),
((SELECT id FROM terms WHERE slug = 'stresna-krytina'), 'en', 'Roofing', 'Surface layer of the roof protecting against weather effects.', 'We chose ceramic tiles as roofing material.');

-- Vzduchotechnika
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'vzduchotechnika'), 'sk', 'Vzduchotechnika', 'Systém zabezpečujúci výmenu vzduchu v budove.', 'Vzduchotechnika je nevyhnutná pre zdravé vnútorné prostredie.'),
((SELECT id FROM terms WHERE slug = 'vzduchotechnika'), 'en', 'Ventilation system', 'System that ensures air exchange in the building.', 'Ventilation system is essential for a healthy indoor environment.');

-- Základová doska
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'zakladova-doska'), 'sk', 'Základová doska', 'Plošný základ prenášajúci zaťaženie objektu do podložia.', 'Základová doska musí byť správne vyarmovaná a hydroizolovaná.'),
((SELECT id FROM terms WHERE slug = 'zakladova-doska'), 'en', 'Foundation slab', 'Flat foundation that transfers the building load to the ground.', 'The foundation slab must be properly reinforced and waterproofed.');

-- Omietka
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'omietka'), 'sk', 'Omietka', 'Povrchová úprava stien vnútorná alebo vonkajšia.', 'Vnútorná omietka sa aplikuje v dvoch vrstvách.'),
((SELECT id FROM terms WHERE slug = 'omietka'), 'en', 'Plaster', 'Surface treatment of walls, interior or exterior.', 'Interior plaster is applied in two layers.');

-- Energetický certifikát
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'energeticky-certifikat'), 'sk', 'Energetický certifikát', 'Dokument hodnotíci energetickú náročnosť budovy.', 'Energetický certifikát je povinný pri predaji nehnuteľnosti.'),
((SELECT id FROM terms WHERE slug = 'energeticky-certifikat'), 'en', 'Energy certificate', 'Document assessing the energy performance of a building.', 'Energy certificate is mandatory when selling real estate.');

-- Tepelné mosty
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'tepelne-mosty'), 'sk', 'Tepelné mosty', 'Miesta s vyšším prestupom tepla v konštrukcii.', 'Tepelné mosty vznikajú hlavne v miestach prerušenia izolácie.'),
((SELECT id FROM terms WHERE slug = 'tepelne-mosty'), 'en', 'Thermal bridges', 'Locations with higher heat transfer in the structure.', 'Thermal bridges occur mainly where insulation is interrupted.');

-- Záveterná lišta
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'zaveterna-lista'), 'sk', 'Záveterná lišta', 'Ochranná lišta na čelnej časti strechy proti vetru.', 'Záveterná lišta chráni konštrukciu strechy pred dažďom a vetrom.'),
((SELECT id FROM terms WHERE slug = 'zaveterna-lista'), 'en', 'Wind barge board', 'Protective board on the front part of the roof against wind.', 'The wind barge board protects the roof structure from rain and wind.');

-- Podlahové kúrenie
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'podlahove-kurenie'), 'sk', 'Podlahové kúrenie', 'Vykurovací systém umiestnený v konštrukcii podlahy.', 'Podlahové kúrenie zabezpečuje rovnomerne rozloženie tepla.'),
((SELECT id FROM terms WHERE slug = 'podlahove-kurenie'), 'en', 'Floor heating', 'Heating system installed in the floor structure.', 'Floor heating ensures even heat distribution.');

-- Parozábrana
INSERT INTO term_translations (term_id, language, term, definition, example_usage) VALUES
((SELECT id FROM terms WHERE slug = 'parozabrana'), 'sk', 'Parozábrana', 'Fólia zabezpečujúca difúzne uzavretie konštrukcie.', 'Parozábrana sa inštaluje z vnútornej strany tepelnej izolácie.'),
((SELECT id FROM terms WHERE slug = 'parozabrana'), 'en', 'Vapor barrier', 'Foil that ensures vapor-tight closure of the structure.', 'Vapor barrier is installed on the interior side of thermal insulation.');

-- ====================================
-- TERM CATEGORIES (Junction table)
-- ====================================

INSERT INTO term_categories (term_id, category_key) VALUES
((SELECT id FROM terms WHERE slug = 'zelezo-beton'), 'material'),
((SELECT id FROM terms WHERE slug = 'zelezo-beton'), 'statics'),
((SELECT id FROM terms WHERE slug = 'tepelna-izolacia'), 'material'),
((SELECT id FROM terms WHERE slug = 'tepelna-izolacia'), 'energy'),
((SELECT id FROM terms WHERE slug = 'nosna-stena'), 'structure'),
((SELECT id FROM terms WHERE slug = 'nosna-stena'), 'statics'),
((SELECT id FROM terms WHERE slug = 'stresna-krytina'), 'material'),
((SELECT id FROM terms WHERE slug = 'stresna-krytina'), 'finishing'),
((SELECT id FROM terms WHERE slug = 'vzduchotechnika'), 'hvac'),
((SELECT id FROM terms WHERE slug = 'zakladova-doska'), 'structure'),
((SELECT id FROM terms WHERE slug = 'zakladova-doska'), 'statics'),
((SELECT id FROM terms WHERE slug = 'omietka'), 'finishing'),
((SELECT id FROM terms WHERE slug = 'energeticky-certifikat'), 'energy'),
((SELECT id FROM terms WHERE slug = 'tepelne-mosty'), 'energy'),
((SELECT id FROM terms WHERE slug = 'zaveterna-lista'), 'structure'),
((SELECT id FROM terms WHERE slug = 'zaveterna-lista'), 'finishing'),
((SELECT id FROM terms WHERE slug = 'podlahove-kurenie'), 'hvac'),
((SELECT id FROM terms WHERE slug = 'podlahove-kurenie'), 'energy'),
((SELECT id FROM terms WHERE slug = 'parozabrana'), 'material'),
((SELECT id FROM terms WHERE slug = 'parozabrana'), 'energy');

-- ====================================
-- VERIFICATION
-- ====================================

SELECT 'Data inserted successfully!' AS message;

SELECT 'Languages' AS table_name, COUNT(*) AS count FROM languages
UNION ALL
SELECT 'Users', COUNT(*) FROM users
UNION ALL
SELECT 'Categories', COUNT(*) FROM categories
UNION ALL
SELECT 'Category-Translations', COUNT(*) FROM category_translations
UNION ALL
SELECT 'Terms', COUNT(*) FROM terms
UNION ALL
SELECT 'Term-Translations', COUNT(*) FROM term_translations
UNION ALL
SELECT 'Term-Categories', COUNT(*) FROM term_categories;
