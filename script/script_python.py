import psycopg

DSN = "dbname=mydb user=admin password=admin host=localhost port=5432"

def init_supershop_db():
    with psycopg.connect(DSN) as conn:
        with conn.cursor() as cur:

            
            cur.execute("CREATE SCHEMA IF NOT EXISTS supershopanalytics;")

           
            cur.execute("DROP TABLE IF EXISTS supershopanalytics.orders_items;")
            cur.execute("DROP TABLE IF EXISTS supershopanalytics.orders;")
            cur.execute("DROP TABLE IF EXISTS supershopanalytics.products;")
            cur.execute("DROP TABLE IF EXISTS supershopanalytics.customers;")
            cur.execute("DROP TABLE IF EXISTS supershopanalytics.categories;")
            cur.execute("DROP TABLE IF EXISTS supershopanalytics.statut_commande;")

           
            cur.execute("""
                CREATE TABLE supershopanalytics.categories (
                    category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    name VARCHAR(50),
                    description VARCHAR(50)
                );
            """)

         
            cur.execute("""
                CREATE TABLE supershopanalytics.customers (
                    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    firstname VARCHAR(255),
                    lastname VARCHAR(255),
                    email VARCHAR(255),
                    created_at DATE NOT NULL
                );
            """)

           
            cur.execute("""
                CREATE TABLE supershopanalytics.statut_commande (
                    statut_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    status_name VARCHAR(255) NOT NULL
                );
            """)

        
            cur.execute("""
                CREATE TABLE supershopanalytics.products (
                    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    name VARCHAR(255),
                    price DECIMAL,
                    stock INT,
                    category_id INT NOT NULL REFERENCES supershopanalytics.categories(category_id)
                );
            """)

           
            cur.execute("""
                CREATE TABLE supershopanalytics.orders (
                    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    order_date DATE,
                    statut_id INT NOT NULL REFERENCES supershopanalytics.statut_commande(statut_id),
                    customer_id INT NOT NULL REFERENCES supershopanalytics.customers(customer_id)
                );
            """)

            
            cur.execute("""
                CREATE TABLE supershopanalytics.orders_items (
                    product_id INT NOT NULL REFERENCES supershopanalytics.products(product_id),
                    order_id INT NOT NULL REFERENCES supershopanalytics.orders(order_id),
                    quantity INT,
                    price DECIMAL,
                    PRIMARY KEY (product_id, order_id)
                );
            """)

            # ------------------------------------
            # INSERTION DES DONNÉES
            # ------------------------------------

            
            cur.execute("""
                INSERT INTO supershopanalytics.categories (name, description) VALUES
                    ('Électronique', 'Produits high-tech et accessoires'),
                    ('Maison & Cuisine', 'Électroménager et ustensiles'),
                    ('Sport & Loisirs', 'Articles de sport et plein air'),
                    ('Beauté & Santé', 'Produits de beauté, hygiène, bien-être'),
                    ('Jeux & Jouets', 'Jouets pour enfants et adultes');
            """)

            
            cur.execute("""
                INSERT INTO supershopanalytics.products (name, price, stock, category_id) VALUES
                    ('Casque Bluetooth X1000', 79.99, 50, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Électronique')),
                    ('Souris Gamer Pro RGB', 49.90, 120, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Électronique')),
                    ('Bouilloire Inox 1.7L', 29.99, 80, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Maison & Cuisine')),
                    ('Aspirateur Cyclonix 3000', 129.00, 40, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Maison & Cuisine')),
                    ('Tapis de Yoga Comfort+', 19.99, 150, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Sport & Loisirs')),
                    ('Haltères 5kg (paire)', 24.99, 70, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Sport & Loisirs')),
                    ('Crème hydratante BioSkin', 15.90, 200, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Beauté & Santé')),
                    ('Gel douche FreshEnergy', 4.99, 300, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Beauté & Santé')),
                    ('Puzzle 1000 pièces "Montagne"', 12.99, 95, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Jeux & Jouets')),
                    ('Jeu de société "Galaxy Quest"', 29.90, 60, 
                        (SELECT category_id FROM supershopanalytics.categories WHERE name='Jeux & Jouets'));
            """)

            
            cur.execute("""
                INSERT INTO supershopanalytics.customers (firstname, lastname, email, created_at) VALUES
                    ('Alice','Martin','alice.martin@mail.com','2024-01-10'),
                    ('Bob','Dupont','bob.dupont@mail.com','2024-02-05'),
                    ('Chloé','Bernard','chloe.bernard@mail.com','2024-03-12'),
                    ('David','Robert','david.robert@mail.com','2024-01-29'),
                    ('Emma','Leroy','emma.leroy@mail.com','2024-03-02'),
                    ('Félix','Petit','felix.petit@mail.com','2024-02-18'),
                    ('Hugo','Roussel','hugo.roussel@mail.com','2024-03-20'),
                    ('Inès','Moreau','ines.moreau@mail.com','2024-01-17'),
                    ('Julien','Fontaine','julien.fontaine@mail.com','2024-01-23'),
                    ('Katia','Garnier','katia.garnier@mail.com','2024-03-15');
            """)

           
            cur.execute("""
                INSERT INTO supershopanalytics.statut_commande (status_name)
                VALUES ('PAID'), ('SHIPPED'), ('CANCELLED'), ('PENDING');
            """)

            
            cur.execute("""
                INSERT INTO supershopanalytics.orders (order_date, statut_id, customer_id) VALUES
                    ('2024-03-01', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PAID'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='alice.martin@mail.com')),
                    ('2024-03-04', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='SHIPPED'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='bob.dupont@mail.com')),
                    ('2024-03-08', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PAID'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='chloe.bernard@mail.com')),
                    ('2024-03-09', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='CANCELLED'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='david.robert@mail.com')),
                    ('2024-03-10', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PAID'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='emma.leroy@mail.com')),
                    ('2024-03-11', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PENDING'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='felix.petit@mail.com')),
                    ('2024-03-15', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='SHIPPED'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='hugo.roussel@mail.com')),
                    ('2024-03-16', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PAID'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='ines.moreau@mail.com')),
                    ('2024-03-18', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PAID'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='julien.fontaine@mail.com')),
                    ('2024-03-20', (SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name='PENDING'),
                                   (SELECT customer_id FROM supershopanalytics.customers WHERE email='katia.garnier@mail.com'));
            """)

           
            cur.execute("""
                INSERT INTO supershopanalytics.orders_items (product_id, order_id, quantity, price)
                VALUES
                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Casque Bluetooth X1000'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-01' AND c.email='alice.martin@mail.com'),
                     1, 79.99),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Puzzle 1000 pièces "Montagne"'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-01' AND c.email='alice.martin@mail.com'),
                     2, 12.99),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Tapis de Yoga Comfort+'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-04' AND c.email='bob.dupont@mail.com'),
                     1, 19.99),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Bouilloire Inox 1.7L'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-08' AND c.email='chloe.bernard@mail.com'),
                     1, 29.99),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Gel douche FreshEnergy'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-08' AND c.email='chloe.bernard@mail.com'),
                     3, 4.99),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Haltères 5kg (paire)'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-09' AND c.email='david.robert@mail.com'),
                     1, 24.99),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Crème hydratante BioSkin'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-10' AND c.email='emma.leroy@mail.com'),
                     2, 15.90),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Jeu de société "Galaxy Quest"'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-18' AND c.email='julien.fontaine@mail.com'),
                     1, 29.90),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Souris Gamer Pro RGB'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-20' AND c.email='katia.garnier@mail.com'),
                     1, 49.90),

                    ((SELECT product_id FROM supershopanalytics.products WHERE name='Gel douche FreshEnergy'),
                     (SELECT order_id FROM supershopanalytics.orders o JOIN supershopanalytics.customers c 
                        ON o.customer_id=c.customer_id WHERE o.order_date='2024-03-20' AND c.email='katia.garnier@mail.com'),
                     2, 4.99);
            """)

        conn.commit()

    print("Base SuperShopAnalytics initialisée ! ")


init_supershop_db()
