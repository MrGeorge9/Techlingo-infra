-- Techlingo Database Schema
-- PostgreSQL 16
-- Consolidated schema with language support and normalized translations

-- Drop tables if they exist (for clean reinstall)
DROP TABLE IF EXISTS term_categories CASCADE;
DROP TABLE IF EXISTS category_translations CASCADE;
DROP TABLE IF EXISTS term_translations CASCADE;
DROP TABLE IF EXISTS terms CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS languages CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ====================================
-- USERS
-- ====================================
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('USER', 'ADMIN')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ====================================
-- LANGUAGES
-- ====================================
CREATE TABLE languages (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    native_name VARCHAR(100),
    flag VARCHAR(10),
    is_active BOOLEAN NOT NULL DEFAULT true,
    display_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ====================================
-- CATEGORIES
-- ====================================
CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    key VARCHAR(100) NOT NULL UNIQUE
);

-- ====================================
-- CATEGORY TRANSLATIONS
-- ====================================
CREATE TABLE category_translations (
    category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    language VARCHAR(10) NOT NULL REFERENCES languages(code) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id, language)
);

-- ====================================
-- TERMS
-- ====================================
CREATE TABLE terms (
    id BIGSERIAL PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ====================================
-- TERM TRANSLATIONS
-- ====================================
CREATE TABLE term_translations (
    term_id BIGINT NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
    language VARCHAR(10) NOT NULL REFERENCES languages(code) ON DELETE RESTRICT,
    term VARCHAR(500) NOT NULL,
    definition TEXT,
    example_usage TEXT,
    PRIMARY KEY (term_id, language)
);

-- ====================================
-- TERM CATEGORIES (junction table)
-- ====================================
CREATE TABLE term_categories (
    term_id BIGINT NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
    category_key VARCHAR(100) NOT NULL,
    PRIMARY KEY (term_id, category_key)
);

-- ====================================
-- INDEXES
-- ====================================

-- Users indexes
CREATE INDEX idx_users_email ON users(email);

-- Languages indexes
CREATE INDEX idx_languages_code ON languages(code);
CREATE INDEX idx_languages_is_active ON languages(is_active);

-- Categories indexes
CREATE INDEX idx_categories_key ON categories(key);

-- Category translations indexes
CREATE INDEX idx_category_translations_category_id ON category_translations(category_id);
CREATE INDEX idx_category_translations_language ON category_translations(language);
CREATE INDEX idx_category_translations_name ON category_translations(name);

-- Terms indexes
CREATE INDEX idx_terms_slug ON terms(slug);
CREATE INDEX idx_terms_created_at ON terms(created_at);

-- Term translations indexes
CREATE INDEX idx_term_translations_term_id ON term_translations(term_id);
CREATE INDEX idx_term_translations_language ON term_translations(language);
CREATE INDEX idx_term_translations_term ON term_translations(term);

-- Term categories indexes
CREATE INDEX idx_term_categories_term_id ON term_categories(term_id);
CREATE INDEX idx_term_categories_category_key ON term_categories(category_key);

-- Full-text search indexes (for better search performance)
CREATE INDEX idx_term_translations_term_fts ON term_translations USING gin(to_tsvector('simple', term));
CREATE INDEX idx_term_translations_definition_fts ON term_translations USING gin(to_tsvector('simple', definition));
CREATE INDEX idx_term_translations_example_fts ON term_translations USING gin(to_tsvector('simple', example_usage));

-- ====================================
-- COMMENTS
-- ====================================

COMMENT ON TABLE users IS 'Application users with authentication';
COMMENT ON TABLE languages IS 'Supported languages in the application';
COMMENT ON TABLE categories IS 'Construction term categories';
COMMENT ON TABLE category_translations IS 'Translations for category names in different languages';
COMMENT ON TABLE terms IS 'Dictionary terms base info';
COMMENT ON TABLE term_translations IS 'Translations for terms in different languages';
COMMENT ON TABLE term_categories IS 'Junction table linking terms to categories';

COMMENT ON COLUMN users.role IS 'User role: USER or ADMIN';
COMMENT ON COLUMN languages.code IS 'ISO language code (e.g., sk, en, de, cz)';
COMMENT ON COLUMN languages.is_active IS 'Whether the language is currently active';
COMMENT ON COLUMN languages.display_order IS 'Order for displaying languages in UI';
COMMENT ON COLUMN category_translations.category_id IS 'Reference to the category';
COMMENT ON COLUMN category_translations.language IS 'Language code for this translation';
COMMENT ON COLUMN category_translations.name IS 'Translated category name';
COMMENT ON COLUMN terms.slug IS 'URL-friendly identifier';
COMMENT ON COLUMN term_translations.language IS 'Language code (sk, en, de, cz)';
COMMENT ON COLUMN term_translations.term IS 'Translated term';
