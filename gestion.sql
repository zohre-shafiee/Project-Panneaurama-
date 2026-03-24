-- CREATE TABLE languages (
--     id_langue INTEGER NOT NULL PRIMARY KEY,
--     nom_langue TEXT NOT NULL ,
--     glottocode TEXT
-- );

-- CREATE TABLE language_inventory (
--     id_langue INTEGER NOT NULL,
--     id_phoneme INTEGER NOT NULL,
--     PRIMARY KEY (id_langue, id_phoneme),
--     FOREIGN KEY (id_langue) REFERENCES languages(id_langue),
--     FOREIGN KEY (id_phoneme) REFERENCES phonemes(id_phoneme)
-- );

-- CREATE TABLE phonology_descriptions (
--     id_desc INTEGER PRIMARY KEY AUTOINCREMENT,
--     id_langue INTEGER NOT NULL,
--     description_text TEXT,
--     FOREIGN KEY (id_langue) REFERENCES languages(id_langue)
-- );


-- CREATE TABLE ipa_symbols (
--     id_ipa INTEGER PRIMARY KEY AUTOINCREMENT,
--     symbol TEXT NOT NULL UNIQUE,
--     categorie TEXT NOT NULL
--     -- vowel, consonant,  nonpulmonic, diacritic/suprasegmental, tone
-- );


-- CREATE TABLE vowel_features (
--     id_ipa INTEGER PRIMARY KEY,  
--     ferm_ouv TEXT,
--     post_ant TEXT,
--     arrondi TEXT,


--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );


-- CREATE TABLE consonant_features (
--     id_ipa INTEGER PRIMARY KEY,  
--     lieu_dart TEXT,
--     mode_dart TEXT,
--     voise TEXT,

--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );

-- CREATE TABLE other_symbols_features (
--     id_ipa INTEGER PRIMARY KEY,
--     description TEXT NOT NULL,
--     type_articulation TEXT,
--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );

-- CREATE TABLE nonpulmonic_features (
--     id_ipa INTEGER PRIMARY KEY,
--     type TEXT,
--     lieu_dart TEXT,

--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );


-- CREATE TABLE diacritics_supras_features (
--     id_ipa INTEGER PRIMARY KEY,


--     feature_type TEXT,


--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );


-- CREATE TABLE tone_features (
--     id_ipa INTEGER PRIMARY KEY,

--     tone_type TEXT,
--     -- level, contour

--     contour TEXT,
--     -- rising, falling, dipping, peaking

--     level TEXT,
--     -- upper, mid, lower

--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );



-- INSERT INTO ipa_symbols (symbol, categorie) VALUES
-- ('i', 'vowel'), ('y', 'vowel'), ('ɨ', 'vowel'), ('ʉ', 'vowel'), ('ɯ', 'vowel'), ('u', 'vowel'),
-- ('ɪ', 'vowel'), ('ʏ', 'vowel'), ('ʊ', 'vowel'),
-- ('e', 'vowel'), ('ø', 'vowel'), ('ɘ', 'vowel'), ('ɵ', 'vowel'), ('ɤ', 'vowel'), ('o', 'vowel'),
-- ('ə', 'vowel'),
-- ('ɛ', 'vowel'), ('œ', 'vowel'), ('ɜ', 'vowel'), ('ɞ', 'vowel'), ('ʌ', 'vowel'), ('ɔ', 'vowel'),
-- ('æ', 'vowel'), ('ɐ', 'vowel'),
-- ('a', 'vowel'), ('ɶ', 'vowel'), ('ɑ', 'vowel'), ('ɒ', 'vowel');

-- UPDATE ipa_symbols 
-- SET categorie = 'voyelle' 
-- WHERE categorie = 'vowel';

-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'fermée', 'antérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'i';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'fermée', 'antérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'y';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'fermée', 'centrale', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɨ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'fermée', 'centrale', 'arrondie' FROM ipa_symbols WHERE symbol = 'ʉ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'fermée', 'postérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɯ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'fermée', 'postérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'u';


-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-fermée', 'antérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'e';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-fermée', 'antérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'ø';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-fermée', 'postérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'o';


-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'moyenne', 'centrale', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ə';

-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'ouverte', 'antérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'a';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'ouverte', 'antérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'ɶ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'ouverte', 'postérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɑ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'ouverte', 'postérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'ɒ';


-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'pré-fermée', 'quasi-antérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɪ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'pré-fermée', 'quasi-antérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'ʏ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'pré-fermée', 'quasi-postérieure', 'arrondie' FROM ipa_symbols WHERE symbol = 'ʊ';


-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-fermée', 'centrale', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɘ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-fermée', 'centrale', 'arrondie' FROM ipa_symbols WHERE symbol = 'ɵ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-ouverte', 'centrale', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɜ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-ouverte', 'centrale', 'arrondie' FROM ipa_symbols WHERE symbol = 'ɞ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'pré-ouverte', 'centrale', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɐ';


-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'pré-ouverte', 'antérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'æ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-fermée', 'postérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ɤ';
-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-ouverte', 'postérieure', 'non-arrondie' FROM ipa_symbols WHERE symbol = 'ʌ';

-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-ouverte', 'antérieure', 'non-arrondie' 
-- FROM ipa_symbols WHERE symbol = 'ɛ';

-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-ouverte', 'antérieure', 'arrondie' 
-- FROM ipa_symbols WHERE symbol = 'œ';

-- INSERT INTO vowel_features (id_ipa, ferm_ouv, post_ant, arrondi)
-- SELECT id_ipa, 'mi-ouverte', 'postérieure', 'arrondie' 
-- FROM ipa_symbols WHERE symbol = 'ɔ';


-- -- 1. Insertion dans ipa_symbols (Ordre du tableau API)
-- INSERT INTO ipa_symbols (symbol, categorie) VALUES 
-- -- Occlusives
-- ('p', 'consonne'), ('b', 'consonne'), ('t', 'consonne'), ('d', 'consonne'), ('ʈ', 'consonne'), ('ɖ', 'consonne'), ('c', 'consonne'), ('ɟ', 'consonne'), ('k', 'consonne'), ('g', 'consonne'), ('q', 'consonne'), ('ɢ', 'consonne'), ('ʔ', 'consonne'),
-- -- Nasales
-- ('m', 'consonne'), ('ɱ', 'consonne'), ('n', 'consonne'), ('ɳ', 'consonne'), ('ɲ', 'consonne'), ('ŋ', 'consonne'), ('ɴ', 'consonne'),
-- -- Roulées
-- ('ʙ', 'consonne'), ('r', 'consonne'), ('ʀ', 'consonne'),
-- -- Battues
-- ('ⱱ', 'consonne'), ('ɾ', 'consonne'), ('ɽ', 'consonne'),
-- -- Fricatives
-- ('ɸ', 'consonne'), ('β', 'consonne'), ('f', 'consonne'), ('v', 'consonne'), ('θ', 'consonne'), ('ð', 'consonne'), ('s', 'consonne'), ('z', 'consonne'), ('ʃ', 'consonne'), ('ʒ', 'consonne'), ('ʂ', 'consonne'), ('ʐ', 'consonne'), ('ç', 'consonne'), ('ʝ', 'consonne'), ('x', 'consonne'), ('ɣ', 'consonne'), ('χ', 'consonne'), ('ʁ', 'consonne'), ('ħ', 'consonne'), ('ʕ', 'consonne'), ('h', 'consonne'), ('ɦ', 'consonne'),
-- -- Fricatives Latérales
-- ('ɬ', 'consonne'), ('ɮ', 'consonne'),
-- -- Spirantes (Approximantes)
-- ('ʋ', 'consonne'), ('ɹ', 'consonne'), ('ɻ', 'consonne'), ('j', 'consonne'), ('ɰ', 'consonne'),
-- -- Latérales (Approximantes)
-- ('l', 'consonne'), ('ɭ', 'consonne'), ('ʎ', 'consonne'), ('ʟ', 'consonne');

-- -- 2. Insertion des caractéristiques dans consonant_features
-- -- Occlusives
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'bilabiale', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 'p';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'bilabiale', 'occlusive', 'voisée' FROM ipa_symbols WHERE symbol = 'b';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 't';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'occlusive', 'voisée' FROM ipa_symbols WHERE symbol = 'd';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 'ʈ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'occlusive', 'voisée' FROM ipa_symbols WHERE symbol = 'ɖ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 'c';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'occlusive', 'voisée' FROM ipa_symbols WHERE symbol = 'ɟ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'vélaire', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 'k';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'vélaire', 'occlusive', 'voisée' FROM ipa_symbols WHERE symbol = 'g';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 'q';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'occlusive', 'voisée' FROM ipa_symbols WHERE symbol = 'ɢ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'glottale', 'occlusive', 'sourde' FROM ipa_symbols WHERE symbol = 'ʔ';

-- -- Nasales
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'bilabiale', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'm';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'labio-dentale', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'ɱ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'n';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'ɳ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'ɲ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'vélaire', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'ŋ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'nasale', 'voisée' FROM ipa_symbols WHERE symbol = 'ɴ';

-- -- Roulées
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'bilabiale', 'roulée', 'voisée' FROM ipa_symbols WHERE symbol = 'ʙ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'roulée', 'voisée' FROM ipa_symbols WHERE symbol = 'r';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'roulée', 'voisée' FROM ipa_symbols WHERE symbol = 'ʀ';

-- -- Battues
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'labio-dentale', 'battue', 'voisée' FROM ipa_symbols WHERE symbol = 'ⱱ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'battue', 'voisée' FROM ipa_symbols WHERE symbol = 'ɾ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'battue', 'voisée' FROM ipa_symbols WHERE symbol = 'ɽ';

-- -- Fricatives
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'bilabiale', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'ɸ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'bilabiale', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'β';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'labio-dentale', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'f';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'labio-dentale', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'v';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'dentale', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'θ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'dentale', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ð';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 's';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'z';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'post-alvéolaire', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'ʃ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'post-alvéolaire', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ʒ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'ʂ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ʐ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'ç';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ʝ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'vélaire', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'x';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'vélaire', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ɣ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'χ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ʁ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'pharyngale', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'ħ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'pharyngale', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ʕ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'glottale', 'fricative', 'sourde' FROM ipa_symbols WHERE symbol = 'h';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'glottale', 'fricative', 'voisée' FROM ipa_symbols WHERE symbol = 'ɦ';

-- -- Fricatives Latérales
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'fricative latérale', 'sourde' FROM ipa_symbols WHERE symbol = 'ɬ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'fricative latérale', 'voisée' FROM ipa_symbols WHERE symbol = 'ɮ';

-- -- Spirantes (Approximantes)
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'labio-dentale', 'spirante', 'voisée' FROM ipa_symbols WHERE symbol = 'ʋ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'spirante', 'voisée' FROM ipa_symbols WHERE symbol = 'ɹ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'spirante', 'voisée' FROM ipa_symbols WHERE symbol = 'ɻ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'spirante', 'voisée' FROM ipa_symbols WHERE symbol = 'j';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'vélaire', 'spirante', 'voisée' FROM ipa_symbols WHERE symbol = 'ɰ';

-- -- Latérales (Approximantes)
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'alvéolaire', 'latérale', 'voisée' FROM ipa_symbols WHERE symbol = 'l';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'rétroflexe', 'latérale', 'voisée' FROM ipa_symbols WHERE symbol = 'ɭ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'palatale', 'latérale', 'voisée' FROM ipa_symbols WHERE symbol = 'ʎ';
-- INSERT INTO consonant_features (id_ipa, lieu_dart, mode_dart, voise) SELECT id_ipa, 'uvulaire', 'latérale', 'voisée' FROM ipa_symbols WHERE symbol = 'ʟ';

-- SELECT * FROM consonant_features;

-- INSERT INTO ipa_symbols (symbol, categorie) VALUES 
-- -- Clics
-- ('ʘ', 'consonne non-pulmonique'), 
-- ('ǀ', 'consonne non-pulmonique'), 
-- ('ǃ', 'consonne non-pulmonique'), 
-- ('ǂ', 'consonne non-pulmonique'), 
-- ('ǁ', 'consonne non-pulmonique'),
-- -- Implosives
-- ('ɓ', 'consonne non-pulmonique'), 
-- ('ɗ', 'consonne non-pulmonique'), 
-- ('ʄ', 'consonne non-pulmonique'), 
-- ('ɠ', 'consonne non-pulmonique'), 
-- ('ʛ', 'consonne non-pulmonique'),
-- -- Éjectives (Le crochet/apostrophe est le symbole de base)
-- ('ʼ', 'consonne non-pulmonique');


-- -- Clic bilabial
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'clic', 'bilabiale' FROM ipa_symbols WHERE symbol = 'ʘ';

-- -- Clic dental
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'clic', 'dentale' FROM ipa_symbols WHERE symbol = 'ǀ';

-- -- Clic (post)alvéolaire
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'clic', 'alvéolaire' FROM ipa_symbols WHERE symbol = 'ǃ';

-- -- Clic palato-alvéolaire
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'clic', 'palato-alvéolaire' FROM ipa_symbols WHERE symbol = 'ǂ';

-- -- Clic alvéolaire latéral
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'clic', 'latérale alvéolaire' FROM ipa_symbols WHERE symbol = 'ǁ';

-- -- Implosive bilabiale
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'implosive', 'bilabiale' FROM ipa_symbols WHERE symbol = 'ɓ';

-- -- Implosive dentale/alvéolaire
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'implosive', 'dentale/alvéolaire' FROM ipa_symbols WHERE symbol = 'ɗ';

-- -- Implosive palatale
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'implosive', 'palatale' FROM ipa_symbols WHERE symbol = 'ʄ';

-- -- Implosive vélaire
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'implosive', 'vélaire' FROM ipa_symbols WHERE symbol = 'ɠ';

-- -- Implosive uvulaire
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'implosive', 'uvulaire' FROM ipa_symbols WHERE symbol = 'ʛ';



-- -- Symbole modificateur pour les éjectives
-- INSERT INTO nonpulmonic_features (id_ipa, type, lieu_dart)
-- SELECT id_ipa, 'éjective', 'variable' FROM ipa_symbols WHERE symbol = 'ʼ';


-- CREATE TABLE other_symbols_features (
--     id_ipa INTEGER PRIMARY KEY,
--     description TEXT NOT NULL,
--     -- Ex: 'fricative labio-vélaire sourde'
    
--     type_articulation TEXT, 
--     -- Ex: 'co-articulé', 'épiglottal', 'alvéolo-palatal'

--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );


-- INSERT INTO ipa_symbols (symbol, categorie) VALUES 
-- ('ʍ', 'autre'), ('w', 'autre'), ('ɥ', 'autre'), 
-- ('ʜ', 'autre'), ('ʢ', 'autre'), ('ʡ', 'autre'), 
-- ('ɕ', 'autre'), ('ʑ', 'autre'), ('ɺ', 'autre'), ('ɧ', 'autre');

-- -- Sons co-articulés et complexes
-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'fricative labio-vélaire sourde', 'co-articulé' FROM ipa_symbols WHERE symbol = 'ʍ';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'spirante labio-vélaire voisée', 'co-articulé' FROM ipa_symbols WHERE symbol = 'w';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'spirante labio-palatale voisée', 'co-articulé' FROM ipa_symbols WHERE symbol = 'ɥ';

-- -- Sons épiglottaux
-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'fricative épiglottale sourde', 'épiglottal' FROM ipa_symbols WHERE symbol = 'ʜ';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'fricative épiglottale voisée', 'épiglottal' FROM ipa_symbols WHERE symbol = 'ʢ';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'occlusive épiglottale', 'épiglottal' FROM ipa_symbols WHERE symbol = 'ʡ';

-- -- Alvéolo-palatales et autres
-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'fricative alvéolo-palatale sourde', 'alvéolo-palatal' FROM ipa_symbols WHERE symbol = 'ɕ';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'fricative alvéolo-palatale voisée', 'alvéolo-palatal' FROM ipa_symbols WHERE symbol = 'ʑ';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'battue latérale alvéolaire voisée', 'alvéolaire' FROM ipa_symbols WHERE symbol = 'ɺ';

-- INSERT INTO other_symbols_features (id_ipa, description, type_articulation)
-- SELECT id_ipa, 'fricative post-alvéolaire et vélaire sourde simultanée', 'co-articulé' FROM ipa_symbols WHERE symbol = 'ɧ';

-- INSERT INTO ipa_symbols (symbol, categorie) VALUES 
-- -- Diacritiques
-- ('̥', 'diacritique'), ('̬', 'diacritique'), ('ʰ', 'diacritique'), ('̹', 'diacritique'), 
-- ('̜', 'diacritique'), ('̟', 'diacritique'), ('̠', 'diacritique'), ('̈', 'diacritique'), 
-- ('̽', 'diacritique'), ('̩', 'diacritique'), ('̯', 'diacritique'), ('˞', 'diacritique'), 
-- ('̤', 'diacritique'), ('̰', 'diacritique'), ('̼', 'diacritique'), ('ʷ', 'diacritique'), 
-- ('ʲ', 'diacritique'), ('ˠ', 'diacritique'), ('ˤ', 'diacritique'), ('̴', 'diacritique'), 
-- ('̝', 'diacritique'), ('̞', 'diacritique'), ('̘', 'diacritique'), ('̙', 'diacritique'), 
-- ('̪', 'diacritique'), ('̺', 'diacritique'), ('̻', 'diacritique'), ('̃', 'diacritique'), 
-- ('ⁿ', 'diacritique'), ('ˡ', 'diacritique'), ('̚', 'diacritique'),
-- -- Suprasegmentaux
-- ('ˈ', 'suprasegmental'), ('ˌ', 'suprasegmental'), ('ː', 'suprasegmental'), 
-- ('ˑ', 'suprasegmental'), ('̆', 'suprasegmental'), ('|', 'suprasegmental'), 
-- ('‖', 'suprasegmental'), ('.', 'suprasegmental'), ('‿', 'suprasegmental');

-- -- État de la glotte et expiration
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'dévoisé' FROM ipa_symbols WHERE symbol = '̥';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'voisé' FROM ipa_symbols WHERE symbol = '̬';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'aspiré' FROM ipa_symbols WHERE symbol = 'ʰ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'murmuré' FROM ipa_symbols WHERE symbol = '̤';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'craqué' FROM ipa_symbols WHERE symbol = '̰';

-- -- Articulations secondaires (Co-articulation)
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'labialisé' FROM ipa_symbols WHERE symbol = 'ʷ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'palatalisé' FROM ipa_symbols WHERE symbol = 'ʲ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'vélarisé' FROM ipa_symbols WHERE symbol = 'ˠ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'pharyngalisé' FROM ipa_symbols WHERE symbol = 'ˤ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'nasalisé' FROM ipa_symbols WHERE symbol = '̃';

-- -- Position et mouvement de la langue
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'avancé' FROM ipa_symbols WHERE symbol = '̟';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'rétracté' FROM ipa_symbols WHERE symbol = '̠';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'centralisé' FROM ipa_symbols WHERE symbol = '̈';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'relevé' FROM ipa_symbols WHERE symbol = '̝';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'abaissé' FROM ipa_symbols WHERE symbol = '̞';

-- -- Détails de contact
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'dental' FROM ipa_symbols WHERE symbol = '̪';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'apical' FROM ipa_symbols WHERE symbol = '̺';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'laminal' FROM ipa_symbols WHERE symbol = '̻';


-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'accent primaire' FROM ipa_symbols WHERE symbol = 'ˈ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'accent secondaire' FROM ipa_symbols WHERE symbol = 'ˌ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'long' FROM ipa_symbols WHERE symbol = 'ː';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'mi-long' FROM ipa_symbols WHERE symbol = 'ˑ';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'extra-bref' FROM ipa_symbols WHERE symbol = '̆';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'pause mineure' FROM ipa_symbols WHERE symbol = '|';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'pause majeure' FROM ipa_symbols WHERE symbol = '‖';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'coupe syllabique' FROM ipa_symbols WHERE symbol = '.';
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) SELECT id_ipa, 'liaison' FROM ipa_symbols WHERE symbol = '‿';


-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) VALUES 
-- (112, 'plus arrondi'),
-- (113, 'moins arrondi'),
-- (117, 'mi-centralisé'),
-- (118, 'syllabique'),
-- (119, 'non-syllabique'),
-- (120, 'rhoticité');


-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) VALUES 
-- (123, 'linguolabial'),
-- (131, 'racine de la langue avancée'),
-- (132, 'racine de la langue rétractée'),
-- (137, 'déclenchement nasal'),
-- (138, 'déclenchement latéral'),
-- (139, 'fin sans relâchement audible');

-- INSERT INTO diacritics_supras_features (id_ipa, feature_type)
-- VALUES (128, 'vélarisé ou pharyngalisé');

-- INSERT INTO ipa_symbols (symbol, categorie) VALUES 
-- -- Tons de niveau (Level tones)
-- ('˥', 'ton'), ('˦', 'ton'), ('˧', 'ton'), ('˨', 'ton'), ('˩', 'ton'),
-- -- Tons modulés (Contour tones)
-- ('˩˧', 'ton'), ('˥˩', 'ton'), ('˧˥', 'ton'), ('˩˨', 'ton'), ('˦˥˦', 'ton');

-- -- Tons de niveau
-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'niveau', 'plat', 'haut' FROM ipa_symbols WHERE symbol = '˥';

-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'niveau', 'plat', 'haut' FROM ipa_symbols WHERE symbol = '˦';

-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'niveau', 'plat', 'moyen' FROM ipa_symbols WHERE symbol = '˧';

-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'niveau', 'plat', 'bas' FROM ipa_symbols WHERE symbol = '˨';

-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'niveau', 'plat', 'bas' FROM ipa_symbols WHERE symbol = '˩';

-- -- Tons modulés
-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'modulé', 'montant', 'variable' FROM ipa_symbols WHERE symbol = '˩˧';

-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'modulé', 'descendant', 'variable' FROM ipa_symbols WHERE symbol = '˥˩';

-- INSERT INTO tone_features (id_ipa, tone_type, contour, level)
-- SELECT id_ipa, 'modulé', 'convexe', 'variable' FROM ipa_symbols WHERE symbol = '˦˥˦';


-- -- This table creates the identity of the phoneme
-- CREATE TABLE phonemes (
--     id_phoneme INTEGER PRIMARY KEY AUTOINCREMENT,
--     phoneme_label TEXT NOT NULL UNIQUE -- e.g., 'aɪ̃', 't͡ʃʰ'
-- );

-- This table defines the sequence of symbols
-- CREATE TABLE phoneme_sequence (
--     id_phoneme INTEGER,
--     id_ipa INTEGER,    -- Reference to your ipa_symbols table
--     position INTEGER,  -- 1, 2, 3... to keep them in order
--     PRIMARY KEY (id_phoneme, position),
--     FOREIGN KEY(id_phoneme) REFERENCES phonemes(id_phoneme),
--     FOREIGN KEY(id_ipa) REFERENCES ipa_symbols(id_ipa)
-- );

-- INSERT INTO phonemes (phoneme_label) 
-- VALUES ('aɪ̃');

-- -- Inserting /a/ at position 1
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position)
-- VALUES ((SELECT id_phoneme FROM phonemes WHERE phoneme_label = 'aɪ̃'), 25, 1);

-- -- Inserting /ɪ/ at position 2
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position)
-- VALUES ((SELECT id_phoneme FROM phonemes WHERE phoneme_label = 'aɪ̃'), 7, 2);

-- -- Inserting the nasal diacritic /̃/ at position 3
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position)
-- VALUES ((SELECT id_phoneme FROM phonemes WHERE phoneme_label = 'aɪ̃'), 128, 3);


-- SELECT 
--     ps.position,
--     s.symbol,
--     s.categorie,
--     COALESCE(v.ferm_ouv, c.mode_dart, d.feature_type) AS characteristique_1,
--     COALESCE(v.post_ant, c.lieu_dart) AS characteristique_2,
--     v.arrondi AS rounding
-- FROM phoneme_sequence ps
-- JOIN ipa_symbols s ON ps.id_ipa = s.id_ipa
-- LEFT JOIN vowel_features v ON s.id_ipa = v.id_ipa
-- LEFT JOIN consonant_features c ON s.id_ipa = c.id_ipa
-- LEFT JOIN diacritics_supras_features d ON s.id_ipa = d.id_ipa
-- WHERE ps.id_phoneme = (SELECT id_phoneme FROM phonemes WHERE phoneme_label = 'aɪ̃')
-- ORDER BY ps.position;


-- INSERT INTO languages (id_langue, nom_langue, glottocode) VALUES 
-- (1, 'French', 'stan1290'),
-- (2, 'Bengali', 'beng1280'),
-- (3, 'Bulgarian', 'bulg1262');

-- -- Clearing existing data to ensure a clean 103-language inventory
-- DELETE FROM languages;

-- INSERT INTO languages (id_langue, nom_langue, glottocode) VALUES 
-- (1, 'Afar', 'afar1241'),
-- (2, 'Afrikaans', 'afri1274'),
-- (3, 'Albanais', 'tosk1239'),
-- (4, 'Allemand', 'stan1295'),
-- (5, 'Amharique', 'amha1245'),
-- (6, 'Anglais', 'stan1293'),
-- (7, 'Arabe', 'stan1318'),
-- (8, 'Arabe de Juba', 'suda1237'),
-- (9, 'Arménien occidental', 'homs1234'),
-- (10, 'Arménien oriental', 'nucl1235'),
-- (11, 'Balante ganja', 'bala1302'),
-- (12, 'Bambara', 'bamb1269'),
-- (13, 'Baoulé', 'baou1238'),
-- (14, 'Basaa', 'basa1284'),
-- (15, 'Basque', 'basq1248'),
-- (16, 'Bengali', 'beng1280'),
-- (17, 'Berbère', 'tach1250'),
-- (18, 'Birman', 'nucl1310'),
-- (19, 'Bulgare', 'bulg1262'),
-- (20, 'Breton', 'bret1244'),
-- (21, 'Catalan', 'stan1289'),
-- (22, 'Chinois mandarin', 'mand1415'),
-- (23, 'Comorien', 'ngaz1238'),
-- (24, 'Coréen', 'kore1280'),
-- (25, 'Créole capverdien', 'kabul1256'),
-- (26, 'Créole guadeloupéen', 'guad1242'),
-- (27, 'Créole haïtien', 'hait1244'),
-- (28, 'Créole martiniquais', 'mar1259'),
-- (29, 'Créole mauricien', 'mori1278'),
-- (30, 'Créole réunionais', 'reun1238'),
-- (31, 'Créole vincentien', 'vinc1243'),
-- (32, 'Danois', 'dani1285'),
-- (33, 'Dari', 'dari1249'),
-- (34, 'Espagnol', 'stan1288'),
-- (35, 'Ewe', 'ewee1241'),
-- (36, 'Fang boulou', 'bulu1251'),
-- (37, 'Fang ntoumou', 'ntum1238'),
-- (38, 'Filipino', 'fili1244'),
-- (39, 'Finnois', 'finn1318'),
-- (40, 'Français', 'stan1290'),
-- (41, 'Galicien', 'gali1258'),
-- (42, 'Géorgien', 'nucl1302'),
-- (43, 'Grec', 'mode1248'),
-- (44, 'Haoussa', 'haus1257'),
-- (45, 'Hébreu', 'hebr1245'),
-- (46, 'Hindi', 'hind1269'),
-- (47, 'Hongrois', 'hung1274'),
-- (48, 'Islandais', 'icel1247'),
-- (49, 'Italien', 'ital1282'),
-- (50, 'Japonais', 'nucl1643'),
-- (51, 'Joola fooni', 'jola1263'),
-- (52, 'Kabyle', 'kaby1243'),
-- (53, 'Kazakh', 'kaza1248'),
-- (54, 'Khmer', 'cent1989'),
-- (55, 'Kriol', 'uppe1455'),
-- (56, 'Kurde kurmandji', 'nort2641'),
-- (57, 'Kurde sorani', 'cent1972'),
-- (58, 'Laze', 'lazz1240'),
-- (59, 'Letton', 'stan1325'),
-- (60, 'Lingala', 'ling1263'),
-- (61, 'Luxembourgeois', 'luxe1241'),
-- (62, 'Malgache', 'plat1254'),
-- (63, 'Maltais', 'malt1254'),
-- (64, 'Mandinka', 'mand1436'),
-- (65, 'Manjaku', 'mand1418'),
-- (66, 'Mina', 'genn1243'),
-- (67, 'Néerlandais', 'dutc1256'),
-- (68, 'Népali', 'nepal1254'),
-- (69, 'Occitan', 'occi1239'),
-- (70, 'Ourdou', 'urdu1245'),
-- (71, 'Pashto', 'nort2646'),
-- (72, 'Penjabi', 'panj1256'),
-- (73, 'Persan', 'west2369'),
-- (74, 'Peul', 'pula1263'),
-- (75, 'Polonais', 'poli1260'),
-- (76, 'Portugais', 'port1283'),
-- (77, 'Provençal', 'prov1235'),
-- (78, 'Romanche', 'roma1326'),
-- (79, 'Roumain', 'roma1327'),
-- (80, 'Rromani', 'vlax1238'),
-- (81, 'Russe', 'russ1263'),
-- (82, 'Saamaka', 'sara1340'),
-- (83, 'Sango', 'sang1328'),
-- (84, 'Sérère', 'sere1260'),
-- (85, 'Singhalais', 'sinh1246'),
-- (86, 'Slovaque', 'slov1269'),
-- (87, 'Somali', 'soma1255'),
-- (88, 'Soninké', 'soni1259'),
-- (89, 'Soso', 'susu1250'),
-- (90, 'Suédois', 'swed1254'),
-- (91, 'Swahili', 'swah1253'),
-- (92, 'Tamoul', 'tami1289'),
-- (93, 'Tchétchène', 'chec1245'),
-- (94, 'Tchèque', 'czec1258'),
-- (95, 'Tibétain', 'tibe1272'),
-- (96, 'Tigrigna', 'tigr1271'),
-- (97, 'Tswana', 'tswa1253'),
-- (98, 'Turc', 'nucl1301'),
-- (99, 'Ukrainien', 'ukra1253'),
-- (100, 'Vietnamien', 'viet1252'),
-- (101, 'Wolof', 'nucl1347'),
-- (102, 'Yiddish', 'east2295'),
-- (103, 'Yoruba', 'yoru1245');

-- DELETE FROM phonemes;
-- DELETE FROM phoneme_sequence;

-- -- Seed the Phonemes using the exact same IDs as the IPA Symbols
-- INSERT INTO phonemes (id_phoneme, phoneme_label)
-- SELECT id_ipa, symbol 
-- FROM ipa_symbols 
-- WHERE id_ipa <= 108; [cite: 2]

-- -- Seed the Sequences so that Phoneme ID X always points to IPA ID X
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position)
-- SELECT id_ipa, id_ipa, 1
-- FROM ipa_symbols 
-- WHERE id_ipa <= 108; [cite: 2]

-- -- This forces Phoneme ID 1 to be IPA ID 1, Phoneme ID 2 to be IPA ID 2, etc.
-- INSERT INTO phonemes (id_phoneme, phoneme_label)
-- SELECT id_ipa, symbol 
-- FROM ipa_symbols 
-- WHERE id_ipa <= 108;

-- -- This links Phoneme ID 1 to Symbol ID 1, Phoneme ID 2 to Symbol ID 2, etc.
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position)
-- SELECT id_ipa, id_ipa, 1
-- FROM ipa_symbols 
-- WHERE id_ipa <= 108;


-- -- Adding the missing voiced aspiration diacritic
-- INSERT INTO ipa_symbols (id_ipa, symbol, categorie) VALUES (159, 'ʱ', 'diacritique');
-- INSERT INTO diacritics_supras_features (id_ipa, feature_type) VALUES (159, 'voisement soufflé (aspiré voisé)');


-- -- Adding Complex Phonemes to the library
-- INSERT INTO phonemes (id_phoneme, phoneme_label) VALUES 
-- -- Affricates
-- (109, 'tɕ'), (110, 'dʑ'), (111, 'ts'), (112, 'dz'), (113, 'ʈʂ'), 
-- (114, 'ɖʐ'), (115, 'tʃ'), (116, 'dʒ'), (117, 'tsʲ'),

-- -- Aspirated / Breathy
-- (118, 'pʰ'), (119, 'bʱ'), (120, 'tʰ'), (121, 'dʱ'), (122, 'ʈʰ'), 
-- (123, 'ɖʱ'), (124, 'kʰ'), (125, 'gʱ'), (126, 'tʃʰ'), (127, 'dʒʱ'), 
-- (128, 'ɽʱ'), (129, 'gʰ'), (130, 'cʰ'), (131, 'ɟʰ'), (132, 'ɖʰ'), 
-- (133, 'dʰ'), (134, 'bʰ'), (135, 'ɟʱ'), (136, 'g̤ʱ'),

-- -- Nasalized
-- (137, 'ɑ̃'), (138, 'ɔ̃'), (139, 'ɛ̃'), (140, 'ĩː'), (141, 'ɪ̃'), 
-- (142, 'ẽː'), (143, 'ɛ̃ː'), (144, 'ə̃'), (145, 'ä̃ː'), (146, 'ũː'), 
-- (147, 'ʊ̃'), (148, 'õː'), (149, 'ɔ̃ː'), (150, 'ĩ'), (151, 'ũ'), 
-- (152, 'ẽ'), (153, 'ã'), (154, 'õ'), (155, 'æ̃'), (156, 'əĩ'), (157, 'əũ'),

-- -- Long Vowels
-- (158, 'iː'), (159, 'eː'), (160, 'ɛː'), (161, 'äː'), (162, 'uː'), 
-- (163, 'oː'), (164, 'ɔː'), (165, 'ɑː'), (166, 'ɜː'),

-- -- Diphthongs
-- (167, 'əi'), (168, 'əu'), (169, 'ɑj'), (170, 'æj'), (171, 'ɔj'), 
-- (172, 'aɪ'), (173, 'aʊ'), (174, 'eɪ'), (175, 'əʊ'), (176, 'ɔɪ'), 
-- (177, 'ɪə'), (178, 'eə'), (179, 'ʊə'),

-- -- Palatalized
-- (180, 'pʲ'), (181, 'bʲ'), (182, 'tʲ'), (183, 'dʲ'), (184, 'mʲ'), 
-- (185, 'rʲ'), (186, 'fʲ'), (187, 'vʲ'), (188, 'sʲ'), (189, 'zʲ'),

-- -- Modified
-- (190, 'ä'), (191, 'ɤ̟');

-- -- 1. Affricates
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (109, 31, 1), (109, 105, 2),  -- tɕ (t + ɕ)
-- (110, 32, 1), (110, 106, 2),  -- dʑ (d + ʑ)
-- (111, 31, 1), (111, 61, 2),   -- ts (t + s)
-- (112, 32, 1), (112, 62, 2),   -- dz (d + z)
-- (113, 33, 1), (113, 65, 2),   -- ʈʂ (ʈ + ʂ)
-- (114, 34, 1), (114, 66, 2),   -- ɖʐ (ɖ + ʐ)
-- (115, 31, 1), (115, 63, 2),   -- tʃ (t + ʃ)
-- (116, 32, 1), (116, 64, 2),   -- dʒ (d + ʒ)
-- (117, 31, 1), (117, 61, 2), (117, 125, 3); -- tsʲ (t + s + ʲ)

-- -- 2. Aspirated / Breathy
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (118, 29, 1), (118, 111, 2),  -- pʰ (p + ʰ)
-- (119, 30, 1), (119, 159, 2),  -- bʱ (b + ʱ)
-- (120, 31, 1), (120, 111, 2),  -- tʰ (t + ʰ)
-- (121, 32, 1), (121, 159, 2),  -- dʱ (d + ʱ)
-- (122, 33, 1), (122, 111, 2),  -- ʈʰ (ʈ + ʰ)
-- (123, 34, 1), (123, 159, 2),  -- ɖʱ (ɖ + ʱ)
-- (124, 37, 1), (124, 111, 2),  -- kʰ (k + ʰ)
-- (125, 38, 1), (125, 159, 2),  -- gʱ (g + ʱ)
-- (126, 31, 1), (126, 63, 2), (126, 111, 3), -- tʃʰ (t + ʃ + ʰ)
-- (127, 32, 1), (127, 64, 2), (127, 159, 3), -- dʒʱ (d + ʒ + ʱ)
-- (128, 54, 1), (128, 159, 2),  -- ɽʱ (ɽ + ʱ)
-- (129, 38, 1), (129, 111, 2),  -- gʰ (g + ʰ)
-- (130, 35, 1), (130, 111, 2),  -- cʰ (c + ʰ)
-- (131, 36, 1), (131, 111, 2),  -- ɟʰ (ɟ + ʰ)
-- (132, 34, 1), (132, 111, 2),  -- ɖʰ (ɖ + ʰ)
-- (133, 32, 1), (133, 111, 2),  -- dʰ (d + ʰ)
-- (134, 30, 1), (134, 111, 2),  -- bʰ (b + ʰ)
-- (135, 36, 1), (135, 159, 2),  -- ɟʱ (ɟ + ʱ)
-- (136, 38, 1), (136, 121, 2), (136, 159, 3); -- g̤ʱ (g + ̤ + ʱ)

-- -- 3. Nasalized Vowels
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (137, 27, 1), (137, 136, 2),  -- ɑ̃ (ɑ + ̃)
-- (138, 22, 1), (138, 136, 2),  -- ɔ̃ (ɔ + ̃)
-- (139, 17, 1), (139, 136, 2),  -- ɛ̃ (ɛ + ̃)
-- (140, 1, 1), (140, 136, 2), (140, 142, 3), -- ĩː (i + ̃ + ː)
-- (141, 7, 1), (141, 136, 2),   -- ɪ̃ (ɪ + ̃)
-- (142, 10, 1), (142, 136, 2), (142, 142, 3), -- ẽː (e + ̃ + ː)
-- (143, 17, 1), (143, 136, 2), (143, 142, 3), -- ɛ̃ː (ɛ + ̃ + ː)
-- (144, 16, 1), (144, 136, 2),  -- ə̃ (ə + ̃)
-- (145, 25, 1), (145, 116, 2), (145, 136, 3), (145, 142, 4), -- ä̃ː (a + ̈ + ̃ + ː)
-- (146, 6, 1), (146, 136, 2), (146, 142, 3),  -- ũː (u + ̃ + ː)
-- (147, 9, 1), (147, 136, 2),   -- ʊ̃ (ʊ + ̃)
-- (148, 15, 1), (148, 136, 2), (148, 142, 3), -- õː (o + ̃ + ː)
-- (149, 22, 1), (149, 136, 2), (149, 142, 3), -- ɔ̃ː (ɔ + ̃ + ː)
-- (150, 1, 1), (150, 136, 2),   -- ĩ (i + ̃)
-- (151, 6, 1), (151, 136, 2),   -- ũ (u + ̃)
-- (152, 10, 1), (152, 136, 2),  -- ẽ (e + ̃)
-- (153, 25, 1), (153, 136, 2),  -- ã (a + ̃)
-- (154, 15, 1), (154, 136, 2),  -- õ (o + ̃)
-- (155, 23, 1), (155, 136, 2),  -- æ̃ (æ + ̃)
-- (156, 16, 1), (156, 1, 2), (156, 136, 3),   -- əĩ (ə + i + ̃)
-- (157, 16, 1), (157, 6, 2), (157, 136, 3);   -- əũ (ə + u + ̃)

-- -- 4. Long Vowels
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (158, 1, 1), (158, 142, 2),   -- iː
-- (159, 10, 1), (159, 142, 2),  -- eː
-- (160, 17, 1), (160, 142, 2),  -- ɛː
-- (161, 25, 1), (161, 116, 2), (161, 142, 3), -- äː (a + ̈ + ː)
-- (162, 6, 1), (162, 142, 2),   -- uː
-- (163, 15, 1), (163, 142, 2),  -- oː
-- (164, 22, 1), (164, 142, 2),  -- ɔː
-- (165, 27, 1), (165, 142, 2),  -- ɑː
-- (166, 19, 1), (166, 142, 2);  -- ɜː

-- -- 5. Diphthongs
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (167, 16, 1), (167, 1, 2),    -- əi
-- (168, 16, 1), (168, 6, 2),    -- əu
-- (169, 27, 1), (169, 82, 2),   -- ɑj (ɑ + j)
-- (170, 23, 1), (170, 82, 2),   -- æj (æ + j)
-- (171, 22, 1), (171, 82, 2),   -- ɔj (ɔ + j)
-- (172, 25, 1), (172, 7, 2),    -- aɪ (a + ɪ)
-- (173, 25, 1), (173, 9, 2),    -- aʊ (a + ʊ)
-- (174, 10, 1), (174, 7, 2),    -- eɪ (e + ɪ)
-- (175, 16, 1), (175, 9, 2),    -- əʊ (ə + ʊ)
-- (176, 22, 1), (176, 7, 2),    -- ɔɪ (ɔ + ɪ)
-- (177, 7, 1), (177, 16, 2),    -- ɪə (ɪ + ə)
-- (178, 10, 1), (178, 16, 2),   -- eə (e + ə)
-- (179, 9, 1), (179, 16, 2);    -- ʊə (ʊ + ə)

-- -- 6. Palatalized Consonants
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (180, 29, 1), (180, 125, 2),  -- pʲ
-- (181, 30, 1), (181, 125, 2),  -- bʲ
-- (182, 31, 1), (182, 125, 2),  -- tʲ
-- (183, 32, 1), (183, 125, 2),  -- dʲ
-- (184, 42, 1), (184, 125, 2),  -- mʲ
-- (185, 50, 1), (185, 125, 2),  -- rʲ
-- (186, 57, 1), (186, 125, 2),  -- fʲ
-- (187, 58, 1), (187, 125, 2),  -- vʲ
-- (188, 61, 1), (188, 125, 2),  -- sʲ
-- (189, 62, 1), (189, 125, 2);  -- zʲ

-- -- 7. Modified Vowels
-- INSERT INTO phoneme_sequence (id_phoneme, id_ipa, position) VALUES 
-- (190, 25, 1), (190, 116, 2),  -- ä (a + ̈)
-- (191, 14, 1), (191, 114, 2);  -- ɤ̟ (ɤ + ̟)


-- -- Français (ID 40)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (40, 29), (40, 30), (40, 42), (40, 57), (40, 58), (40, 31), (40, 32), (40, 44), (40, 61), (40, 62),
-- (40, 84), (40, 63), (40, 64), (40, 46), (40, 37), (40, 38), (40, 72), (40, 82), (40, 101), (40, 100),
-- (40, 1), (40, 10), (40, 17), (40, 2), (40, 11), (40, 18), (40, 16), (40, 25), (40, 6), (40, 15),
-- (40, 22), (40, 137), (40, 138), (40, 139), (40, 153); -- includes ã

-- -- Polonais (ID 75)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (75, 29), (75, 30), (75, 57), (75, 58), (75, 31), (75, 32), (75, 61), (75, 62), (75, 109), (75, 110),
-- (75, 105), (75, 106), (75, 111), (75, 112), (75, 113), (75, 114), (75, 65), (75, 66), (75, 37), (75, 38),
-- (75, 69), (75, 35), (75, 36), (75, 42), (75, 44), (75, 82), (75, 100), (75, 25), (75, 17), (75, 22),
-- (75, 1), (75, 6), (75, 3);

-- -- Italien (ID 49)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (49, 29), (49, 30), (49, 57), (49, 58), (49, 42), (49, 100), (49, 31), (49, 32), (49, 111), (49, 112),
-- (49, 61), (49, 62), (49, 44), (49, 84), (49, 53), (49, 115), (49, 116), (49, 63), (49, 46), (49, 86),
-- (49, 82), (49, 37), (49, 38), (49, 1), (49, 10), (49, 17), (49, 25), (49, 22), (49, 15), (49, 6);

-- -- Hindi (ID 46)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (46, 29), (46, 118), (46, 30), (46, 119), (46, 31), (46, 120), (46, 32), (46, 121), (46, 33), (46, 122),
-- (46, 34), (46, 123), (46, 37), (46, 124), (46, 38), (46, 125), (46, 115), (46, 126), (46, 116), (46, 127),
-- (46, 57), (46, 61), (46, 62), (46, 65), (46, 63), (46, 76), (46, 42), (46, 44), (46, 84), (46, 50),
-- (46, 54), (46, 128), (46, 79), (46, 82), (46, 158), (46, 7), (46, 159), (46, 160), (46, 23), (46, 16),
-- (46, 162), (46, 9), (46, 163), (46, 164), (46, 141), (46, 143), (46, 144), (46, 147), (46, 149);

-- -- Népali (ID 68)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (68, 37), (68, 124), (68, 38), (68, 129), (68, 47), (68, 35), (68, 130), (68, 36), (68, 131), (68, 33),
-- (68, 122), (68, 34), (68, 132), (68, 31), (68, 120), (68, 32), (68, 133), (68, 44), (68, 29), (68, 118),
-- (68, 30), (68, 134), (68, 42), (68, 82), (68, 50), (68, 84), (68, 100), (68, 61), (68, 75), (68, 1),
-- (68, 6), (68, 10), (68, 25), (68, 15), (68, 16), (68, 144), (68, 167), (68, 168);

-- -- Ourdou (ID 70)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (70, 29), (70, 118), (70, 30), (70, 119), (70, 31), (70, 120), (70, 32), (70, 121), (70, 33), (70, 122),
-- (70, 34), (70, 123), (70, 37), (70, 124), (70, 38), (70, 136), (70, 115), (70, 126), (70, 116), (70, 127),
-- (70, 57), (70, 61), (70, 62), (70, 65), (70, 63), (70, 76), (70, 42), (70, 44), (70, 84), (70, 50),
-- (70, 54), (70, 128), (70, 79), (70, 82), (70, 70), (70, 69), (70, 39), (70, 158), (70, 7), (70, 159),
-- (70, 160), (70, 23), (70, 16), (70, 162), (70, 9), (70, 163), (70, 164), (70, 141), (70, 143), (70, 144),
-- (70, 147), (70, 149);

-- -- Bengali (Dhaka) (ID 16)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (16, 29), (16, 30), (16, 31), (16, 32), (16, 35), (16, 36), (16, 37), (16, 38), (16, 118), (16, 119),
-- (16, 120), (16, 121), (16, 130), (16, 135), (16, 124), (16, 125), (16, 61), (16, 63), (16, 42), (16, 44),
-- (16, 47), (16, 84), (16, 50), (16, 75), (16, 100), (16, 82), (16, 27), (16, 1), (16, 10), (16, 15),
-- (16, 6), (16, 22), (16, 23), (16, 137), (16, 138), (16, 155), (16, 169), (16, 170), (16, 171);

-- -- Bulgare (Standard) (ID 19)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (19, 29), (19, 30), (19, 42), (19, 57), (19, 58), (19, 31), (19, 32), (19, 61), (19, 62), (19, 111),
-- (19, 112), (19, 44), (19, 50), (19, 63), (19, 115), (19, 64), (19, 116), (19, 82), (19, 37), (19, 69),
-- (19, 38), (19, 180), (19, 181), (19, 182), (19, 183), (19, 35), (19, 36), (19, 117), (19, 184), (19, 46),
-- (19, 185), (19, 186), (19, 187), (19, 188), (19, 189), (19, 86), (19, 17), (19, 1), (19, 191), (19, 22), (19, 6);

-- -- Anglais (RP) (ID 6)
-- INSERT INTO language_inventory (id_langue, id_phoneme) VALUES 
-- (6, 29), (6, 30), (6, 31), (6, 32), (6, 37), (6, 38), (6, 115), (6, 116), (6, 57), (6, 58),
-- (6, 59), (6, 60), (6, 61), (6, 62), (6, 63), (6, 64), (6, 75), (6, 42), (6, 44), (6, 47),
-- (6, 84), (6, 80), (6, 100), (6, 82), (6, 158), (6, 7), (6, 10), (6, 23), (6, 165), (6, 21),
-- (6, 166), (6, 16), (6, 162), (6, 9), (6, 164), (6, 28), (6, 174), (6, 172), (6, 175), (6, 173),
-- (6, 176), (6, 177), (6, 178), (6, 179);

-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
-- 6, 
-- 'Les systèmes vocaliques de l''anglais et du français sont sensiblement différents : même les voyelles qui
-- existent dans les deux langues diffèrent par leur point ou mode d''articulation, ex. : anglais tick, lack, pool,
-- day [tɪk,læk,pu:l,deɪ], français tique, laque, poule, dé, dès [tik,lak,pul,de,dɛ]. Les anglophones doivent
-- apprendre à ne pas diphtonguer les voyelles en français (en prononçant par ex. le fait [lə''feɪ]) et à produire
-- [y] et [ø] qui n''existent pas en anglais. La distinction [œ/ø] (soeur/ceux, de [dœ]/deux) est
-- particulièrement difficile. Les voyelles nasales sont distinctives en français (pas/pan, pot/pont, paix/pain),
-- alors qu''elles n''interviennent en anglais que sous l''influence d''une consonne nasale suivante (land (''pays,
-- terre'') [læ̃nd], pan (''casserole'') [pæ̃:n], comparer français l''Inde [lɛ̃d], pain [pɛ̃]). L''anglais et le français
-- ont des prosodies différentes : accent de mot en anglais, accent final de groupe en français : Mary adores
-- chocolate [''mæ:rɪə''dɔ:rz''tʃɒklɪt], Marie adore le chocolat [maʁiadɔʁləʃɔkɔla]. Les anglophones tendront à
-- produire un accent de mot en français (le chocolat [lə''ʃɔkɔla]. Les consonnes du français nécessitant un
-- entraînement particulier sont principalement le [ʁ] fricatif uvulaire, surtout en fin de mot (port [pɔʁ] et
-- devant consonne (porte [pɔʁt], portique [pɔʁtik], les palatales [ɲ] et [j] en position finale (saigne [sɛɲ];
-- paye [pɛj] et pas [peɪ], fouille [fuj] et pas [fuɪ]), feuille [fœj] et la semi-consonne [ɥ] (huit [ɥit], buée
-- [bɥe], sueur [sɥœʁ].'
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
-- 16, 
-- 'Les voyelles [y], [ø], [œ] (pu, peu, peur) du français n’existent pas en bengali. Le bengali distingue
-- des consonnes dentales [t,d] et des consonnes rétroflexes ([ʈ,ɖ]) articulées contre les alvéoles avec la
-- pointe de la langue. Le r uvulaire [ʁ] du français standard est difficile à prononcer pour les
-- bengalophones, habitués à un [r] roulé. La prononciation d''un groupe [Consonne+ʁ] (cri, trop) est
-- compliquée : les bengalophones tendent à insérer une voyelle entre les deux consonnes ([forãs] pour
-- France) ou à supprimer le r — en prononçant français comme foncé ou fossé. Le bengali standard ne
-- connait pas les sons [z] (fr. case) et [d] (fr. cage), qui tendent à être remplacés par le son [v]. Le son
-- [v] n’existe pas non plus clairement en bengali et tend à être confondu avec [b]. De la même façon, il y
-- a une fréquente confusion entre les sons [p] et [f].'
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
--  19, 
-- 'Comme toutes les langues slaves des pays orthodoxes, le bulgare s’écrit au moyen de l’alphabet
-- cyrillique. En général, l''orthographe bulgare respecte une règle stricte : toutes les lettres sont
-- prononcées. Il est important de savoir que certaines lettres qui ont la même forme dans l''alphabet
-- cyrillique et l''alphabet latin ne transcrivent pas les mêmes sons. Ainsi en cyrillique la lettre Н se
-- prononce [v], c se prononce toujours [s], g se prononce [d], p se prononce [r]. Compte tenu des
-- différences phonétiques et phonologiques entre le français et le bulgare, les bulgarophones pourraient
-- rencontrer des difficultés à prononcer des sons typiques du français : le é fermé et toutes les voyelles
-- nasales, méconnues du bulgare. D’autres sons pourraient conserver une sonorité typique bulgare : le a réduit [ə] hors accent, le l alvéolaire [ɫ] devant a, o, ou, le r [r] toujours roulé, le h [x] toujours prononcé en bulgare. En position finale, les sonores pourraient être assourdies : salade [sa''lat]. Le
-- bulgare possède un accent dynamique mobile et les apprenants doivent faire attention à l’accent final de groupe du français.'
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
--  46, 
--  'Les systèmes vocaliques du hindi et du français diffèrent d''abord par la longueur des voyelles, pertinente
-- en hindi ([ba:l] ''cheveu''/bal ''force'' ; [ki:] ''de''/ki ''que'') mais pas en français. Les sons [y] (rue), [ø] (peu) et
-- [œ] (peur), qui n’existent pas en hindi, non plus que la nasalité distinctive des voyelles (pas/pan,
-- peau/pon, paix/pain), demanderont un effort particulier aux apprenants du français. Pour les consonnes,
-- la principale particularité concerne les occlusives dentales, qui sont articulées différemment en hindi et
-- en français : les hindiphones tendent à réaliser [t,d] comme des rétroflexes ([ʈ,ɖ]) articulées contre les
-- alvéoles avec la langue incurvée, et qui s’opposent en hindi aux dentales. La fricative uvulaire [ʁ] du français pose aussi problème car le r est roulé en hindi. Dans plusieurs variétés de hindi, les sons [z] et
-- [f] n’existent pas et tendent à être respectivement remplacés en français par les consonnes [v] et [pʰ]
-- (disponibles en hindi) : pose [podʒ], fait [pʰɛ]). La palatale non affriquée [ʒ] (joue), absente en hindi, est
-- également difficile à acquérir, alors que la sourde correspondante [ʃ] (chou) fait partie du système hindi.
-- L’accent de mot étant important en hindi, et fonction de la longueur des voyelles ([laɽki:], [a:di:]), l’accent
-- final de groupe du français est difficile à acquérir.'
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
--  49, 
-- 'Les italophones tendent à transférer au français le r "roulé" [r] de l''italien : le r "grasseyé" [ʁ] requiert un
-- entraînement spécifique.
-- Les voyelles antérieures arrondies [y] (pu), [ø] (feu), [œ] (peur), [ə] (je/me/le) sont absentes en italien,
-- ainsi que les voyelles nasales [ɛ̃] (bain), [ɑ̃] (banc), [õ] (bon). L''amuïssement du [ə] dans certaines
-- positions, notamment à la finale des mots, ne vient pas naturellement aux italophones, qui tendent à le
-- réaliser partout — comme les francophones méridionaux : cette perle [sɛtœpɛrlœ]. Ils tendent aussi à
-- transférer au français l''accent de mot italien, en allongeant l''avant-dernière syllabe des mots.
-- Pour ceux qui ont été alphabétisés en italien, certaines correspondances différentes entre graphie et
-- prononciation méritent une attention particulière :
-- GRAPHIE PRONONCIATION ITALIENNE PRONONCIATION FRANÇAISE
-- c+i, e [y] cielo [''yɛlo] [s] ciel [sjɛl]
-- sc+i, e [ʃ] scienza [''ʃɛntsa] [s] science [sjãs]
-- g+i, e [dʒ] giraffa [dʒi''raffa] [ʒ] girafe [ʒiʁaf]
-- ch+i, e [k] chiuso ''fermé'' [''kjuzo] [ʃ] chien [ʃjɛ̃]
-- qu [kw] quattro [''kwattro] [k] quatre [katʁ]
-- z [ts] zenit [''tsenit] [z] zénith [zenit]
-- ai [aj] farai ''(tu) feras'' [fa''raj] [ɛ],[e] j''ai [dɛ], [de]
-- oi [oj] poi ''puis'' [poi] [wa] loi [lwa]
-- au [aw] causa [kawsa] [o] cause [koz]
-- eu [ew] neurologia [newroloˈdʒia] [ø] neurologie [nøʁolodi]
-- Par ailleurs, les graphies italiennes et françaises ne découpent pas toujours les mots de la même façon :
-- ital. stamattina, stasera/français ce matin, ce soir ; ital. vederla/français la voir (cf. ex. (15d)) ; italien alla
-- quale, français à laquelle (cf. ex. (11)); etc.


-- --- EXTRACTED DATA TABLES ---
-- | GRAPHIE | PRONONCIATION ITALIENNE |                             | PRONONCIATION FRANÇAISE |                       |
-- |---------|-------------------------|-----------------------------|-------------------------|-----------------------|
-- | c+i, e  | [y]                     | cielo [''yɛlo]               | [s]                     | ciel [sjɛl]           |
-- | sc+i, e | [ʃ]                     | scienza [''ʃɛntsa]           | [s]                     | science [sjãs]        |
-- | g+i, e  | [dʒ]                    | giraffa [dʒi''raffa]         | [ʒ]                     | girafe [ʒiʁaf]        |
-- | ch+i, e | [k]                     | chiuso ''fermé'' [''kjuzo]     | [ʃ]                     | chien [ʃjɛ̃]           |
-- | qu      | [kw]                    | quattro [''kwattro]          | [k]                     | quatre [katʁ]         |
-- | z       | [ts]                    | zenit [''tsenit]             | [z]                     | zénith [zenit]        |
-- | ai      | [aj]                    | farai ''(tu) feras'' [fa''raj] | [ɛ],[e]                 | j''ai [dɛ], [de]       |
-- | oi      | [oj]                    | poi ''puis'' [poi]            | [wa]                    | loi [lwa]             |
-- | au      | [aw]                    | causa [kawsa]               | [o]                     | cause [koz]           |
-- | eu      | [ew]                    | neurologia [newroloˈdʒia]   | [ø]                     | neurologie [nøʁolodi] |

-- '
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
-- 68, 
-- 'Les onze voyelles népalaises sont les suivantes : /i/, /u/, /e/, /o/, /ʌ/, /a/, /ĩ/, /ũ/, /ẽ/, /ʌ̃/, et /ã/. Les népalphones ont souvent des difficultés à distinguer en français /e/ et /ɛ/ (fée vs. fais), /o/ et /ɔ/ (vôtre vs. votre), ou encore /œ/ et /ɔ/ (peur vs. port). La prononciation des voyelles françaises étant articulée avec plus de tension musculaire, les népalphones n’arrivent souvent pas bien à produire la bonne distinction entre[i] et [e] (il dit vs elle dit) mais aussi entre [u] et [o] (soule vs saule). La qualité nasale
-- des voyelles nasales françaises et népalaises étant différente, il y a une confusion dans les deux sens
-- (perception et production) entre [ã] et [ɔ̃] (cancer vs concert) et entre [ɛ̃] et [ã] (sain vs sang). La voyelle
-- [y] n’existe pas en népali, la production de celle-ci pose donc un problème pour les népalophones ([tudi]
--  pour tu dis).
-- Si le népali possède un nombre important de consonnes occlusives, il a en revanche seulement deux
-- fricatives, /s/ et /h/. Les fricatives françaises /f/, /v/, /ʃ/, /z/, et /ʒ/ sont absentes dans cette langue.
-- Les locuteurs du népali produisent en général [dz] à la place de [ʒ], [bɔ̃dzuʁ] pour bonjour), ou encore
-- [sa] à la place de [ʃa] (chat). Ils ont également de la difficulté pour produire la fricative uvulaire /ʁ/, à
-- la place de laquelle on entend souvent une fricative alvéolaire ("roulée") /r/. Le népali est une langue
-- sans accent lexical, comme le français. Cependant, contrairement au français, le népali n’a pas d’accent
-- montant à la fin des groupes de mots ou des phrases. Les népalophones ont du mal à intégrer cette
--  intonation propre du français lors de la production.'
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
--  70, 
-- 'Les systèmes vocaliques de l’ourdou et du français diffèrent d''abord par la longueur des
-- voyelles, pertinente en ourdou ([ba:l] ''cheveu''/bal ''force'' ; un ''eux''/[u:n] ’laine’) mais pas en
-- français. Les sons [y] (rue), [ø] (peu) et [œ] (peur), qui n’existent pas en ourdou, non plus
-- que la nasalité distinctive des voyelles (pas/pan, peau/pon, paix/pain), demanderont un effort
-- particulier aux apprenants du français. Pour les consonnes, la principale particularité concerne
-- les occlusives dentales, articulées différemment en ourdou et en français : les ourdouphones
-- tendent à réaliser [t,d] comme des rétroflexes ([ʈ,ɖ]) articulées contre les alvéoles avec la
-- langue incurvée, et qui s’opposent aux dentales. La fricative uvulaire [ʁ] du français pose aussi
-- problème car le r est roulé en ourdou. La palatale non affriquée [ʒ] (joue), absente en ourdou
-- courant, est également difficile à acquérir, alors que la sourde correspondante [ʃ] (chou) fait
-- partie du système ourdou. L’accent de mot étant important en ourdou, et fonction de la
-- longueur des voyelles ([laɽki:], [a:di:]), l’accent final de groupe du français est difficile à acquérir.'
-- );


-- INSERT INTO phonology_descriptions (id_langue, description_text) VALUES (
-- 75, 
-- 'Le polonais est une langue riche en consonnes : le français possède 17 consonnes, le polonais en a 38.
-- Toutes les consonnes du français existent en polonais sauf le r dorsal qui n’est pas facile à apprendre
-- pour un polonophone. En revanche, la richesse vocalique du français pose de sérieuses difficultés aux
-- Polonais : les trois voyelles antérieures arrondies [y] (pu), [ø] (peu), [œ] (peur), les voyelles fermées [e]
-- (pied), [o] (beau), l’opposition entre [a] antérieur (par) et [ɑ] postérieur (pas), e muet [ə] (haltegarderie), les voyelles nasales [œ̃] (brun), [ɛ̃] (brin), [õ] (bon), [ɑ̃] (banc), la semi-voyelle [ɥ] (fuite).
-- Une autre difficulté pour un polonophone est de prononcer des consonnes voisées à la fin des mots :
-- salade > [salat], crève > [kref], etc. Les nombreuses liaisons, si caractéristiques de la prononciation
-- française (les [z] enfants, mon [n] ami, cet [t] enfant) sont également très difficiles pour les apprenants
-- polonophones. Alors que chaque mot est accentué en polonais sur son avant-dernière syllabe, l''accent
-- frappe en français la dernière syllabe d''un groupe de souffle (va plus loin, je le ferai plus tard, etc.).'
-- );


-- To look at what is inside each table

-- SELECT * FROM languages;
-- SELECT * FROM ipa_symbols;
-- SELECT * FROM tone_features;
-- SELECT * FROM consonant_features;
-- SELECT * FROM diacritics_supras_features;
-- SELECT * FROM vowel_features;
-- SELECT * FROM other_symbols_features;
-- SELECT * FROM nonpulmonic_features;
-- SELECT * FROM phonemes;
-- SELECT * FROM phoneme_sequence;
-- SELECT * FROM phonology_descriptions;

-- List All Phonemes for a Specific Language

-- SELECT 
--     l.nom_langue AS Language, 
--     p.phoneme_label AS Phoneme
-- FROM languages l
-- JOIN language_inventory li ON l.id_langue = li.id_langue
-- JOIN phonemes p ON li.id_phoneme = p.id_phoneme
-- WHERE l.nom_langue = 'Français' -- Change 'Français' to any language in your list
-- ORDER BY p.id_phoneme ASC;


-- Find All Languages that Contain a Specific Phoneme

-- SELECT 
--     l.nom_langue AS Language, 
--     l.glottocode AS Glottocode
-- FROM languages l
-- JOIN language_inventory li ON l.id_langue = li.id_langue
-- JOIN phonemes p ON li.id_phoneme = p.id_phoneme
-- WHERE p.phoneme_label = 'ɑ̃' -- Search for any phoneme label from your list
-- ORDER BY l.nom_langue;

-- Count the Number of Phonemes per Language

-- SELECT 
--     l.nom_langue AS Language, 
--     COUNT(li.id_phoneme) AS Total_Phonemes
-- FROM languages l
-- LEFT JOIN language_inventory li ON l.id_langue = li.id_langue
-- GROUP BY l.id_langue, l.nom_langue
-- ORDER BY Total_Phonemes DESC;

-- Language to IPA Components: 
--      If you want to see a language's phonemes 
--      and also see exactly which IPA symbols make up those phonemes.

-- SELECT 
--     l.nom_langue AS Language, 
--     p.phoneme_label AS Phoneme,
--     ps.position AS IPA_Order,
--     s.symbol AS IPA_Symbol,
--     s.categorie AS Category
-- FROM languages l
-- JOIN language_inventory li ON l.id_langue = li.id_langue
-- JOIN phonemes p ON li.id_phoneme = p.id_phoneme
-- JOIN phoneme_sequence ps ON p.id_phoneme = ps.id_phoneme
-- JOIN ipa_symbols s ON ps.id_ipa = s.id_ipa
-- WHERE l.nom_langue = 'Hindi'
-- ORDER BY p.id_phoneme, ps.position;
