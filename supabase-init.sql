-- Script SQL pour initialiser les tables Supabase pour le système de consultation de résultats médicaux
-- Institut Pasteur de Tunis

-- Activer l'extension UUID si nécessaire
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table pour les demandes d'adhésion
CREATE TABLE IF NOT EXISTS adhesion_requests (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telephone VARCHAR(20) NOT NULL,
    departement VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'en_attente' CHECK (status IN ('en_attente', 'approuve', 'rejete')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les articles
CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    contenu TEXT NOT NULL,
    auteur VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'brouillon' CHECK (status IN ('publie', 'brouillon', 'archive')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les accès aux résultats
CREATE TABLE IF NOT EXISTS resultat_access (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telephone VARCHAR(20) NOT NULL,
    actif BOOLEAN DEFAULT true,
    dernier_acces TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les résultats médicaux
CREATE TABLE IF NOT EXISTS resultats (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    resultat TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les conventions partenaires
CREATE TABLE IF NOT EXISTS conventions (
    id SERIAL PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    designation VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    icon VARCHAR(50) NOT NULL,
    color VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table pour les membres du bureau élu
CREATE TABLE IF NOT EXISTS election_members (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    gender VARCHAR(3) NOT NULL CHECK (gender IN ('M', 'Mme')),
    order_num INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Créer des indexes pour améliorer les performances
CREATE INDEX IF NOT EXISTS idx_adhesion_requests_email ON adhesion_requests(email);
CREATE INDEX IF NOT EXISTS idx_adhesion_requests_status ON adhesion_requests(status);
CREATE INDEX IF NOT EXISTS idx_adhesion_requests_created_at ON adhesion_requests(created_at);

CREATE INDEX IF NOT EXISTS idx_articles_status ON articles(status);
CREATE INDEX IF NOT EXISTS idx_articles_created_at ON articles(created_at);

CREATE INDEX IF NOT EXISTS idx_resultat_access_email ON resultat_access(email);
CREATE INDEX IF NOT EXISTS idx_resultat_access_actif ON resultat_access(actif);

CREATE INDEX IF NOT EXISTS idx_resultats_email ON resultats(email);
CREATE INDEX IF NOT EXISTS idx_resultats_created_at ON resultats(created_at);

CREATE INDEX IF NOT EXISTS idx_conventions_category ON conventions(category);
CREATE INDEX IF NOT EXISTS idx_conventions_designation ON conventions(designation);

CREATE INDEX IF NOT EXISTS idx_election_members_order ON election_members(order_num);

-- Activer Row Level Security (RLS)
ALTER TABLE adhesion_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE resultat_access ENABLE ROW LEVEL SECURITY;
ALTER TABLE resultats ENABLE ROW LEVEL SECURITY;
ALTER TABLE conventions ENABLE ROW LEVEL SECURITY;
ALTER TABLE election_members ENABLE ROW LEVEL SECURITY;

-- Politiques RSL pour permettre toutes les opérations (à ajuster selon vos besoins de sécurité)
DROP POLICY IF EXISTS "Enable all operations for adhesion_requests" ON adhesion_requests;
CREATE POLICY "Enable all operations for adhesion_requests" ON adhesion_requests
    FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Enable all operations for articles" ON articles;
CREATE POLICY "Enable all operations for articles" ON articles
    FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Enable all operations for resultat_access" ON resultat_access;
CREATE POLICY "Enable all operations for resultat_access" ON resultat_access
    FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Enable all operations for resultats" ON resultats;
CREATE POLICY "Enable all operations for resultats" ON resultats
    FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Enable all operations for conventions" ON conventions;
CREATE POLICY "Enable all operations for conventions" ON conventions
    FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Enable all operations for election_members" ON election_members;
CREATE POLICY "Enable all operations for election_members" ON election_members
    FOR ALL USING (true) WITH CHECK (true);

-- Fonction pour mettre à jour le champ updated_at automatiquement
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers pour mettre à jour updated_at automatiquement
DROP TRIGGER IF EXISTS update_adhesion_requests_updated_at ON adhesion_requests;
CREATE TRIGGER update_adhesion_requests_updated_at
    BEFORE UPDATE ON adhesion_requests
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_articles_updated_at ON articles;
CREATE TRIGGER update_articles_updated_at
    BEFORE UPDATE ON articles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_resultat_access_updated_at ON resultat_access;
CREATE TRIGGER update_resultat_access_updated_at
    BEFORE UPDATE ON resultat_access
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_election_members_updated_at ON election_members;
CREATE TRIGGER update_election_members_updated_at
    BEFORE UPDATE ON election_members
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_conventions_updated_at ON conventions;
CREATE TRIGGER update_conventions_updated_at
    BEFORE UPDATE ON conventions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insérer les données initiales pour les conventions partenaires
INSERT INTO conventions (category, designation, phone, address, icon, color) VALUES
-- Banques
('Banques', 'Banque de Tunisie', '+216 71 345 678', 'Avenue Habib Bourguiba, Tunis', 'Building', 'blue'),
('Banques', 'Banque Nationale Agricole', '+216 71 234 567', 'Rue de Rome, Tunis', 'Building', 'green'),
('Banques', 'Société Tunisienne de Banque', '+216 71 890 123', 'Avenue Mohammed V, Tunis', 'Building', 'purple'),
('Banques', 'Banque de l''Habitat', '+216 71 456 789', 'Rue Hédi Nouira, Tunis', 'Building', 'orange'),
('Banques', 'Attijari Bank', '+216 71 567 890', 'Avenue Carthage, Tunis', 'Building', 'red'),

-- Éducation
('Éducation', 'Université de Tunis', '+216 71 876 543', 'Campus Universitaire, Tunis', 'GraduationCap', 'indigo'),
('Éducation', 'Institut Pasteur de Tunis', '+216 71 784 600', 'Rue Pasteur, Belvédère, Tunis', 'GraduationCap', 'emerald'),
('Éducation', 'École Polytechnique de Tunisie', '+216 71 743 700', 'La Marsa, Tunis', 'GraduationCap', 'cyan'),
('Éducation', 'Université de Carthage', '+216 71 654 321', 'Nabeul, Tunisie', 'GraduationCap', 'violet'),
('Éducation', 'Institut Supérieur des Études Technologiques', '+216 71 987 654', 'Rue Kheireddine Pacha, Tunis', 'GraduationCap', 'pink'),

-- Sport
('Sport', 'Stade Olympique de Radès', '+216 71 123 456', 'Radès, Tunis', 'Trophy', 'yellow'),
('Sport', 'Club Africain', '+216 71 234 567', 'Rue du Stade, Tunis', 'Trophy', 'red'),
('Sport', 'Espérance Sportive de Tunis', '+216 71 345 678', 'Avenue Habib Bourguiba, Tunis', 'Trophy', 'red'),
('Sport', 'Fédération Tunisienne de Football', '+216 71 456 789', 'Complexe Sportif d''El Menzah, Tunis', 'Trophy', 'blue'),
('Sport', 'Stade Chedly Zouiten', '+216 71 567 890', 'El Menzah, Tunis', 'Trophy', 'green'),

-- Transport
('Transport', 'Société des Transports de Tunis', '+216 71 678 901', 'Rue d''Allemagne, Tunis', 'Bus', 'blue'),
('Transport', 'Compagnie Tunisienne de Navigation', '+216 71 789 012', 'Port de Tunis, Tunis', 'Ship', 'navy'),
('Transport', 'Tunisair', '+216 71 890 123', 'Aéroport Tunis-Carthage, Tunis', 'Plane', 'sky'),
('Transport', 'SNCFT', '+216 71 901 234', 'Place de Barcelone, Tunis', 'Train', 'emerald'),
('Transport', 'Taxi Tunis', '+216 71 012 345', 'Centre Ville, Tunis', 'Car', 'orange'),

-- Hôtellerie
('Hôtellerie', 'Hôtel Africa', '+216 71 123 456', 'Avenue Habib Bourguiba, Tunis', 'Bed', 'gold'),
('Hôtellerie', 'Hôtel du Lac', '+216 71 234 567', 'Lac de Tunis, Tunis', 'Bed', 'blue'),
('Hôtellerie', 'Hôtel Carlton', '+216 71 345 678', 'Avenue de France, Tunis', 'Bed', 'purple'),
('Hôtellerie', 'Hôtel Majestic', '+216 71 456 789', 'Rue de Rome, Tunis', 'Bed', 'red'),
('Hôtellerie', 'Hôtel Plaza', '+216 71 567 890', 'Place de la Victoire, Tunis', 'Bed', 'green'),

-- Communication
('Communication', 'Tunisie Télécom', '+216 71 678 901', 'Avenue Habib Bourguiba, Tunis', 'Phone', 'blue'),
('Communication', 'Ooredoo Tunisie', '+216 71 789 012', 'Les Berges du Lac, Tunis', 'Phone', 'red'),
('Communication', 'Orange Tunisie', '+216 71 890 123', 'Centre Urbain Nord, Tunis', 'Phone', 'orange'),
('Communication', 'Poste Tunisienne', '+216 71 901 234', 'Rue Charles de Gaulle, Tunis', 'Mail', 'yellow'),
('Communication', 'Expresso', '+216 71 012 345', 'Avenue Paris, Tunis', 'Phone', 'purple'),

-- Services
('Services', 'Société Tunisienne d''Électricité et du Gaz', '+216 71 123 456', 'Rue Hédi Nouira, Tunis', 'Zap', 'yellow'),
('Services', 'SONEDE', '+216 71 234 567', 'Rue de l''Indépendance, Tunis', 'Droplet', 'blue'),
('Services', 'Office National de l''Assainissement', '+216 71 345 678', 'Rue du Ghana, Tunis', 'Droplet', 'cyan'),
('Services', 'Agence Nationale de Gestion des Déchets', '+216 71 456 789', 'Rue de la Liberté, Tunis', 'Trash2', 'green'),
('Services', 'Centre de Calcul El Khawarizmi', '+216 71 567 890', 'Campus Universitaire, Tunis', 'Computer', 'purple'),

-- Industrie
('Industrie', 'Groupe Chimique Tunisien', '+216 71 678 901', 'Gabès, Tunisie', 'Factory', 'gray'),
('Industrie', 'Société Tunisienne de l''Industrie Laitière', '+216 71 789 012', 'Ben Arous, Tunis', 'Factory', 'blue'),
('Industrie', 'Ciments de Bizerte', '+216 71 890 123', 'Bizerte, Tunisie', 'Factory', 'brown'),
('Industrie', 'Société Tunisienne des Industries de Raffinage', '+216 71 901 234', 'Bizerte, Tunisie', 'Factory', 'red'),
('Industrie', 'Usine Sidérurgique', '+216 71 012 345', 'Menzel Bourguiba, Tunis', 'Factory', 'dark');

-- Insérer les données initiales pour les membres du bureau élu
INSERT INTO election_members (name, role, gender, order_num) VALUES
('Dr. Mohamed Ben Salah', 'Président', 'M', 1),
('Pr. Fatma Trabelsi', 'Vice-Présidente', 'Mme', 2),
('Dr. Ali Jemaa', 'Secrétaire Général', 'M', 3),
('Mme. Samia Kallel', 'Secrétaire Générale Adjointe', 'Mme', 4),
('Dr. Nizar Ben Youssef', 'Trésorier', 'M', 5),
('Mme. Leila Boulares', 'Trésorière Adjointe', 'Mme', 6),
('Dr. Kamel Masmoudi', 'Conseiller', 'M', 7),
('Pr. Moncef Gharbi', 'Conseiller', 'M', 8),
('Mme. Najiba Ben Mustapha', 'Conseillère', 'Mme', 9);

-- Mettre à jour les séquences pour éviter les conflits d'ID
SELECT setval('adhesion_requests_id_seq', (SELECT COALESCE(MAX(id), 1) FROM adhesion_requests));
SELECT setval('articles_id_seq', (SELECT COALESCE(MAX(id), 1) FROM articles));
SELECT setval('resultat_access_id_seq', (SELECT COALESCE(MAX(id), 1) FROM resultat_access));
SELECT setval('resultats_id_seq', (SELECT COALESCE(MAX(id), 1) FROM resultats));
SELECT setval('conventions_id_seq', (SELECT COALESCE(MAX(id), 1) FROM conventions));
SELECT setval('election_members_id_seq', (SELECT COALESCE(MAX(id), 1) FROM election_members));

-- Afficher un message de confirmation
SELECT 'Base de données initialisée avec succès!' AS message;