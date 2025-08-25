-- Script SQL pour créer les tables Supabase pour l'Amicale IPT
-- Exécutez ce script dans l'éditeur SQL de votre projet Supabase

-- Activer l'extension Row Level Security (RLS)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table pour les demandes d'adhésion
CREATE TABLE IF NOT EXISTS adhesion_requests (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telephone VARCHAR(20) NOT NULL,
    departement VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'en_attente' CHECK (status IN ('en_attente', 'approuve', 'rejete')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les articles
CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(500) NOT NULL,
    contenu TEXT NOT NULL,
    auteur VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'brouillon' CHECK (status IN ('publie', 'brouillon', 'archive')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les accès aux résultats
CREATE TABLE IF NOT EXISTS resultat_access (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telephone VARCHAR(20) NOT NULL,
    actif BOOLEAN DEFAULT true,
    dernier_acces TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les résultats
CREATE TABLE IF NOT EXISTS resultats (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    resultat VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les conventions
CREATE TABLE IF NOT EXISTS conventions (
    id SERIAL PRIMARY KEY,
    category VARCHAR(255) NOT NULL,
    designation TEXT NOT NULL,
    phone TEXT,
    address TEXT,
    icon VARCHAR(100) NOT NULL,
    color VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les membres du bureau élu
CREATE TABLE IF NOT EXISTS election_members (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK (gender IN ('M', 'Mme')) NOT NULL,
    order_num INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Activer Row Level Security (RLS) sur toutes les tables
ALTER TABLE adhesion_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE resultat_access ENABLE ROW LEVEL SECURITY;
ALTER TABLE resultats ENABLE ROW LEVEL SECURITY;
ALTER TABLE conventions ENABLE ROW LEVEL SECURITY;
ALTER TABLE election_members ENABLE ROW LEVEL SECURITY;

-- Politiques RSL pour les demandes d'adhésion
DROP POLICY IF EXISTS "Adhesion requests public insert" ON adhesion_requests;
CREATE POLICY "Adhesion requests public insert" ON adhesion_requests
    FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Adhesion requests public select" ON adhesion_requests;
CREATE POLICY "Adhesion requests public select" ON adhesion_requests
    FOR SELECT USING (true);

DROP POLICY IF EXISTS "Adhesion requests admin update" ON adhesion_requests;
CREATE POLICY "Adhesion requests admin update" ON adhesion_requests
    FOR UPDATE USING (true);

DROP POLICY IF EXISTS "Adhesion requests admin delete" ON adhesion_requests;
CREATE POLICY "Adhesion requests admin delete" ON adhesion_requests
    FOR DELETE USING (true);

-- Politiques RSL pour les articles
DROP POLICY IF EXISTS "Articles public select" ON articles;
CREATE POLICY "Articles public select" ON articles
    FOR SELECT USING (status = 'publie');

DROP POLICY IF EXISTS "Articles admin all" ON articles;
CREATE POLICY "Articles admin all" ON articles
    FOR ALL USING (true);

-- Politiques RSL pour les accès aux résultats
DROP POLICY IF EXISTS "Resultat access public insert" ON resultat_access;
CREATE POLICY "Resultat access public insert" ON resultat_access
    FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Resultat access public select" ON resultat_access;
CREATE POLICY "Resultat access public select" ON resultat_access
    FOR SELECT USING (true);

DROP POLICY IF EXISTS "Resultat access admin all" ON resultat_access;
CREATE POLICY "Resultat access admin all" ON resultat_access
    FOR ALL USING (true);

-- Politiques RSL pour les résultats
DROP POLICY IF EXISTS "Resultats public insert" ON resultats;
CREATE POLICY "Resultats public insert" ON resultats
    FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Resultats public select" ON resultats;
CREATE POLICY "Resultats public select" ON resultats
    FOR SELECT USING (true);

DROP POLICY IF EXISTS "Resultats admin all" ON resultats;
CREATE POLICY "Resultats admin all" ON resultats
    FOR ALL USING (true);

-- Politiques RSL pour les conventions
DROP POLICY IF EXISTS "Conventions public select" ON conventions;
CREATE POLICY "Conventions public select" ON conventions
    FOR SELECT USING (true);

DROP POLICY IF EXISTS "Conventions admin all" ON conventions;
CREATE POLICY "Conventions admin all" ON conventions
    FOR ALL USING (true);

-- Politiques RSL pour les membres du bureau
DROP POLICY IF EXISTS "Election members public select" ON election_members;
CREATE POLICY "Election members public select" ON election_members
    FOR SELECT USING (true);

DROP POLICY IF EXISTS "Election members admin all" ON election_members;
CREATE POLICY "Election members admin all" ON election_members
    FOR ALL USING (true);

-- Créer des triggers pour mettre à jour updated_at automatiquement
CREATE OR REPLACE FUNCTION handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Appliquer les triggers aux tables qui ont updated_at
DROP TRIGGER IF EXISTS handle_adhesion_requests_updated_at ON adhesion_requests;
CREATE TRIGGER handle_adhesion_requests_updated_at
    BEFORE UPDATE ON adhesion_requests
    FOR EACH ROW
    EXECUTE FUNCTION handle_updated_at();

DROP TRIGGER IF EXISTS handle_articles_updated_at ON articles;
CREATE TRIGGER handle_articles_updated_at
    BEFORE UPDATE ON articles
    FOR EACH ROW
    EXECUTE FUNCTION handle_updated_at();

DROP TRIGGER IF EXISTS handle_resultat_access_updated_at ON resultat_access;
CREATE TRIGGER handle_resultat_access_updated_at
    BEFORE UPDATE ON resultat_access
    FOR EACH ROW
    EXECUTE FUNCTION handle_updated_at();

DROP TRIGGER IF EXISTS handle_conventions_updated_at ON conventions;
CREATE TRIGGER handle_conventions_updated_at
    BEFORE UPDATE ON conventions
    FOR EACH ROW
    EXECUTE FUNCTION handle_updated_at();

DROP TRIGGER IF EXISTS handle_election_members_updated_at ON election_members;
CREATE TRIGGER handle_election_members_updated_at
    BEFORE UPDATE ON election_members
    FOR EACH ROW
    EXECUTE FUNCTION handle_updated_at();

-- Activer la réplication en temps réel
ALTER PUBLICATION supabase_realtime ADD TABLE adhesion_requests;
ALTER PUBLICATION supabase_realtime ADD TABLE articles;
ALTER PUBLICATION supabase_realtime ADD TABLE resultat_access;
ALTER PUBLICATION supabase_realtime ADD TABLE resultats;
ALTER PUBLICATION supabase_realtime ADD TABLE conventions;
ALTER PUBLICATION supabase_realtime ADD TABLE election_members;

-- Insérer les données de démonstration pour les conventions
INSERT INTO conventions (category, designation, phone, address, icon, color) VALUES
('Banques', 'BTK', NULL, NULL, 'Building2', 'text-blue-600'),
('Banques', 'BH', NULL, NULL, 'Building2', 'text-blue-600'),
('Banques', 'UBCI', NULL, NULL, 'Building2', 'text-blue-600'),
('Banques', 'BIAT', NULL, NULL, 'Building2', 'text-blue-600'),
('Banques', 'BTE', NULL, NULL, 'Building2', 'text-blue-600'),
('Banques', 'BT', NULL, NULL, 'Building2', 'text-blue-600'),
('Activités Sociales et Culturelles', 'Ciné Pathé', NULL, NULL, 'Heart', 'text-red-600'),
('Activités Sociales et Culturelles', 'Agence de voyage LTS', NULL, NULL, 'Heart', 'text-red-600'),
('Activités Sociales et Culturelles', 'Agence de voyage TTE', NULL, NULL, 'Heart', 'text-red-600'),
('Activités Sociales et Culturelles', 'Agence de voyage TTA', NULL, NULL, 'Heart', 'text-red-600'),
('Activités Sociales et Culturelles', 'Free oui', NULL, NULL, 'Heart', 'text-red-600'),
('Education', 'Jardin d''enfants et club d''été Liliane Kids (Mont Plaisir)', '24787824', NULL, 'GraduationCap', 'text-green-600'),
('Education', 'Crèche Chicco (Jardin d''El Menzeh2)', '92196385 / 24432569', NULL, 'GraduationCap', 'text-green-600'),
('Education', 'Institut Molière', NULL, NULL, 'GraduationCap', 'text-green-600'),
('Education', 'Tandem', NULL, NULL, 'GraduationCap', 'text-green-600'),
('Education', 'Groupe Scolaire Malek Essaghir', NULL, NULL, 'GraduationCap', 'text-green-600'),
('Education', 'Collège privé Atlas (en cours)', NULL, NULL, 'GraduationCap', 'text-green-600'),
('Sport', 'Académie Sportive Le Petit Athlète (Football et Basketball) Menzeh 1', '99261967 / 22183854 / 55538527', NULL, 'Trophy', 'text-orange-600'),
('Sport', 'Tennis Club de Tunis', NULL, NULL, 'Trophy', 'text-orange-600'),
('Sport', 'Club Sportif de la STEG', NULL, NULL, 'Trophy', 'text-orange-600'),
('Sport', 'Club de natation JSB', NULL, NULL, 'Trophy', 'text-orange-600'),
('Sport', 'Académie Menzeh 1 (Summer Camp)', NULL, NULL, 'Trophy', 'text-orange-600'),
('Sport', 'Académie de Basketball Elite HOOPS', NULL, NULL, 'Trophy', 'text-orange-600'),
('Bureautique', 'Société Centre Tunisien du livre (rue de salines)', '71342462', NULL, 'BookOpen', 'text-purple-600'),
('Bureautique', 'Société Papeterie Elite (Sain Gobain Megrine)', '70284200', NULL, 'BookOpen', 'text-purple-600'),
('Bureautique', 'Librairie Cendrillon (Rue des Tanneurs, Tunis centre ville)', '71255895', NULL, 'BookOpen', 'text-purple-600'),
('Bureautique', 'Société IMB (Port de France)', '71327103', NULL, 'BookOpen', 'text-purple-600'),
('Bureautique', 'Société ZOOM (Rue Alain Savary)', '71282249 / 31300550', NULL, 'BookOpen', 'text-purple-600'),
('Santé et Bien être', 'Dr. Amani Zereli (Medecin Dentiste)', '27622668', NULL, 'Stethoscope', 'text-red-700'),
('Santé et Bien être', 'Zen Parapharmacie (Mutuelle Ville)', '25501500', NULL, 'Stethoscope', 'text-red-700'),
('Santé et Bien être', 'BrariOptic (El Omrane Supérieur)', '98968227 / 71927887 / 71757287', NULL, 'Stethoscope', 'text-red-700'),
('Santé et Bien être', 'Optique Faucon (Avenue Londres)', NULL, NULL, 'Stethoscope', 'text-red-700'),
('Santé et Bien être', 'Kmar Optic (Borj Baccouche (Ariana))', '71712703 / 52381138', NULL, 'Stethoscope', 'text-red-700'),
('Santé et Bien être', 'IK Optique (Le Bardo)', '53377504', NULL, 'Stethoscope', 'text-red-700'),
('Opérateurs Téléphoniques', 'Télécom', NULL, NULL, 'Smartphone', 'text-indigo-600'),
('Opérateurs Téléphoniques', 'Oreedoo', NULL, NULL, 'Smartphone', 'text-indigo-600'),
('Entretien Véhicules', 'Automobiles OTOSURE (Menzeh8)', '71716372 / 99467076', NULL, 'Car', 'text-gray-600');

-- Insérer les membres du bureau élu
INSERT INTO election_members (name, role, gender, order_num) VALUES
('Slimane Miled', 'Président', 'M', 1),
('Imen Ferjeni', 'Vice-Présidente', 'Mme', 2),
('Mehrzia Mahjoub', 'Secrétaire générale', 'Mme', 3),
('Samia Ben Maiz', 'Trésorière', 'Mme', 4),
('Safa Ramdhan', 'Trésorière adjointe', 'Mme', 5),
('Sihem Ellkemel', 'Membre', 'Mme', 6),
('Sana Slema', 'Membre', 'Mme', 7),
('Mehdi Maghraoui', 'Membre', 'M', 8),
('Mohamed Brahem', 'Membre', 'M', 9);

-- Créer un index pour améliorer les performances
CREATE INDEX IF NOT EXISTS idx_adhesion_requests_status ON adhesion_requests(status);
CREATE INDEX IF NOT EXISTS idx_articles_status ON articles(status);
CREATE INDEX IF NOT EXISTS idx_resultat_access_actif ON resultat_access(actif);
CREATE INDEX IF NOT EXISTS idx_resultat_access_dernier_acces ON resultat_access(dernier_acces);
CREATE INDEX IF NOT EXISTS idx_conventions_category ON conventions(category);
CREATE INDEX IF NOT EXISTS idx_election_members_order ON election_members(order_num);

-- Afficher un message de succès
SELECT 'Configuration Supabase terminée avec succès!' as message;