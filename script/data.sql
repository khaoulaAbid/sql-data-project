INSERT INTO supershopanalytics.categories (name, description)
VALUES  
    ('Électronique',       'Produits high-tech et accessoires'),
    ('Maison & Cuisine',   'Électroménager et ustensiles'),
    ('Sport & Loisirs',    'Articles de sport et plein air'),
    ('Beauté & Santé',     'Produits de beauté, hygiène, bien-être'),
    ('Jeux & Jouets',      'Jouets pour enfants et adultes');



INSERT INTO supershopanalytics.products(
	 name, price, stock,category_id)
	VALUES  ('Casque Bluetooth X1000', 79.99,  50,(SELECT category_id from supershopanalytics.categories where name = 'Électronique')),
            ('Souris Gamer Pro RGB',          49.90, 120, (SELECT category_id from supershopanalytics.categories where name = 'Électronique' )),
            ('Bouilloire Inox 1.7L',          29.99,  80,  (SELECT category_id from supershopanalytics.categories where name = 'Maison & Cuisine')),
            ('Aspirateur Cyclonix 3000',     129.00,  40, (SELECT category_id from supershopanalytics.categories where name = 'Maison & Cuisine')),
            ('Tapis de Yoga Comfort+',        19.99, 150,  (SELECT category_id from supershopanalytics.categories where name = 'Sport & Loisirs')),
            ('Haltères 5kg (paire)',          24.99,  70,  (SELECT category_id from supershopanalytics.categories where name = 'Sport & Loisirs')),
            ('Crème hydratante BioSkin',      15.90, 200,  (SELECT category_id from supershopanalytics.categories where name = 'Beauté & Santé')),
            ('Gel douche FreshEnergy',         4.99, 300,  (SELECT category_id from supershopanalytics.categories where name = 'Beauté & Santé')),
            ('Puzzle 1000 pièces "Montagne"', 12.99,  95,  (SELECT category_id from supershopanalytics.categories where name = 'Jeux & Jouets')),
            ('Jeu de société "Galaxy Quest"', 29.90,  60,  (SELECT category_id from supershopanalytics.categories where name = 'Jeux & Jouets'));




  INSERT INTO supershopanalytics.customers(
	firstname, lastname, email, created_at)
	VALUES 	('Alice',  'Martin',    'alice.martin@mail.com',    '2024-01-10 14:32'),
  			('Bob',    'Dupont',    'bob.dupont@mail.com',      '2024-02-05 09:10'),
  			('Chloé',  'Bernard',   'chloe.bernard@mail.com',   '2024-03-12 17:22'),
  			('David',  'Robert',    'david.robert@mail.com',    '2024-01-29 11:45'),
 		    ('Emma',   'Leroy',     'emma.leroy@mail.com',      '2024-03-02 08:55'),
  			('Félix',  'Petit',     'felix.petit@mail.com',     '2024-02-18 16:40'),
  			('Hugo',   'Roussel',   'hugo.roussel@mail.com',    '2024-03-20 19:05'),
  			('Inès',   'Moreau',    'ines.moreau@mail.com',     '2024-01-17 10:15'),
  			('Julien', 'Fontaine',  'julien.fontaine@mail.com', '2024-01-23 13:55'),
  			('Katia',  'Garnier',   'katia.garnier@mail.com',   '2024-03-15 12:00');



INSERT INTO supershopanalytics.statut_commande (status_name)
VALUES
    ('PAID'),
    ('SHIPPED'),
    ('CANCELLED'),
    ('PENDING');


INSERT INTO supershopanalytics.orders (order_date, statut_id, customer_id)
	VALUES  ( '2024-03-01 10:20',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name = 'PAID' ),(SELECT customer_id from supershopanalytics.customers where email = 'alice.martin@mail.com' )),
  ( '2024-03-04 09:12',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name = 'SHIPPED' ),(SELECT customer_id from supershopanalytics.customers where email = 'bob.dupont@mail.com') ),
  ('2024-03-08 15:02',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name = 'PAID' ),(SELECT customer_id from supershopanalytics.customers where email = 'chloe.bernard@mail.com')),
  ('2024-03-09 11:45',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name = 'CANCELLED'  ), (SELECT customer_id from supershopanalytics.customers where email = 'david.robert@mail.com')),
  ( '2024-03-10 08:10',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name =  'PAID'  ) ,(SELECT customer_id from supershopanalytics.customers where email = 'emma.leroy@mail.com') ),
  ( '2024-03-11 13:50',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name =  'PENDING' ) ,(SELECT customer_id from supershopanalytics.customers where email = 'felix.petit@mail.com') ),
  ( '2024-03-15 19:30',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name =  'SHIPPED' ) ,(SELECT customer_id from supershopanalytics.customers where email = 'hugo.roussel@mail.com')),
  ( '2024-03-16 10:00',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name =  'PAID' ),(SELECT customer_id from supershopanalytics.customers where email = 'ines.moreau@mail.com')),
  ( '2024-03-18 14:22',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name =  'PAID' ),(SELECT customer_id from supershopanalytics.customers where email = 'julien.fontaine@mail.com')),
  (  '2024-03-20 18:00',(SELECT statut_id FROM supershopanalytics.statut_commande WHERE status_name =  'PENDING') ,(SELECT customer_id from supershopanalytics.customers where email = 'katia.garnier@mail.com'));





INSERT INTO supershopanalytics.orders_items(product_id, order_id, quantity, price)
VALUES

(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Casque Bluetooth X1000'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-01' AND c.email = 'alice.martin@mail.com'),
    1,
    79.99
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Puzzle 1000 pièces "Montagne"'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-01' AND c.email = 'alice.martin@mail.com'),
    2,
    12.99
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Tapis de Yoga Comfort+'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-04' AND c.email = 'bob.dupont@mail.com'),
    1,
    19.99
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Bouilloire Inox 1.7L'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-08' AND c.email = 'chloe.bernard@mail.com'),
    1,
    29.99
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Gel douche FreshEnergy'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-08' AND c.email = 'chloe.bernard@mail.com'),
    3,
    4.99
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Haltères 5kg (paire)'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-09' AND c.email = 'david.robert@mail.com'),
    1,
    24.99
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Crème hydratante BioSkin'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-10' AND c.email = 'emma.leroy@mail.com'),
    2,
    15.90
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Jeu de société "Galaxy Quest"'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-18' AND c.email = 'julien.fontaine@mail.com'),
    1,
    29.90
),


(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Souris Gamer Pro RGB'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-20' AND c.email = 'katia.garnier@mail.com'),
    1,
    49.90
),

(
    (SELECT product_id FROM supershopanalytics.products WHERE name = 'Gel douche FreshEnergy'),
    (SELECT o.order_id 
       FROM supershopanalytics.orders o
       JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
      WHERE o.order_date = '2024-03-20' AND c.email = 'katia.garnier@mail.com'),
    2,
    4.99
);

##****Partie 3 – Requêtes SQL de base******

##***1***
SELECT customer_id, firstname, lastname, email, created_at
	FROM supershopanalytics.customers 
    ORDER BY created_at ASC ;


##***2***

SELECT  name, price
	FROM supershopanalytics.products
	ORDER BY price DESC ;    

##***3***

SELECT  *
	FROM supershopanalytics.orders
	WHERE (order_date > '2024-03-01' ) and (order_date < '2024-03-08')  ;

##***4***

SELECT *
	FROM supershopanalytics.products
	WHERE price > '50' ;

##***5***

SELECT *
	FROM supershopanalytics.products
	WHERE category_id = (SELECT category_id from supershopanalytics.categories where name like 'Maison%' ) ;    


##**** Partie 4 – Jointures simples

##****1****

SELECT p.name,c.name
	FROM supershopanalytics.products p 
	INNER JOIN supershopanalytics.categories c
	ON p.category_id = c.category_id ;

##****2******

SELECT o.*,c.firstname as prenom ,c.lastname as nom 
	FROM supershopanalytics.orders o 
	INNER JOIN supershopanalytics.customers c
	ON o.customer_id = o.customer_id ;

##****3******

SELECT o.*,c.firstname as prenom ,c.lastname as nom ,p.name  ,t.quantity , t.price
	FROM supershopanalytics.orders o 
	LEFT JOIN supershopanalytics.customers c  ON o.customer_id = o.customer_id 
	LEFT JOIN supershopanalytics.orders_items t  ON o.order_id = t.order_id
	LEFT JOIN supershopanalytics.products p   ON t.product_id = p.product_id;


##*****4******

SELECT o.* FROM supershopanalytics.orders  o
INNER JOIN supershopanalytics.statut_commande c
ON o.statut_id = c.statut_id
WHERE c.status_name = 'PAID' OR c.status_name = 'SHIPPED';


##******* Partie 5 – Jointures avancées


SELECT 
    o.order_date AS "date de commande",
    c.firstname AS prenom,
    c.lastname AS nom,
    p.name AS "liste des produits",
    t.quantity AS quantité,
    t.price AS "prix unitaire facturé",
    SUM(t.quantity * t.price) AS "montant total de la ligne"
FROM supershopanalytics.orders o
INNER JOIN supershopanalytics.customers c 
       ON o.customer_id = c.customer_id
INNER JOIN supershopanalytics.orders_items t 
       ON o.order_id = t.order_id
INNER JOIN supershopanalytics.products p 
       ON t.product_id = p.product_id
GROUP BY 
    o.order_date,
    c.firstname,
    c.lastname,
    p.name,
    t.quantity,
    t.price
ORDER BY o.order_date;

################################

SELECT 
    o.order_id ,
    c.lastname AS nom,
    SUM (t.price) AS "montant total de la commande"

FROM supershopanalytics.orders o
INNER JOIN supershopanalytics.customers c 
       ON o.customer_id = c.customer_id
INNER JOIN supershopanalytics.orders_items t 
       ON o.order_id = t.order_id

GROUP BY 
    o.order_id,
    c.lastname;


#################################


SELECT o.order_id,o.order_date , SUM (t.price)
FROM supershopanalytics.orders o 
LEFT JOIN supershopanalytics.orders_items t 
ON o.order_id = t.order_id
GROUP BY 
o.order_id,o.order_date
HAVING SUM (t.price) > 100 ;



###############################

SELECT
    c.category_id,
    c.name AS "categorie",
    SUM(oi.quantity * oi.price) AS "chiffre_affaires_total"
FROM supershopanalytics.categories c
INNER JOIN supershopanalytics.products p
       ON c.category_id = p.category_id
INNER JOIN supershopanalytics.orders_items oi
       ON p.product_id = oi.product_id
GROUP BY c.category_id, c.name
ORDER BY c.category_id;


#################**Partie 6 – Sous-requêtes

#Lister les produits qui ont été vendus au moins une fois.

SELECT p.product_id,p.name ,COUNT (ot.*)
FROM supershopanalytics.products p
INNER JOIN supershopanalytics.orders_items ot
ON p.product_id = ot.product_id
GROUP BY p.product_id,p.name
HAVING COUNT (ot.*)> 1 ;
################################################
#Lister les produits qui n’ont jamais été vendus.

SELECT p.product_id,p.name 
FROM supershopanalytics.products p
LEFT JOIN supershopanalytics.orders_items ot
ON p.product_id = ot.product_id
AND ot.product_id = NULL
###########################################
#Trouver le client qui a dépensé le plus (TOP 1 en chiffre d’affaires cumulé).

SELECT c.firstname ,
		c.lastname ,
		SUM(oi.quantity * oi.price) AS "chiffre_affaires_total_par_client"

FROM supershopanalytics.orders o
INNER JOIN supershopanalytics.customers c ON o.customer_id = c.customer_id
INNER JOIN supershopanalytics.orders_items oi ON o.order_id = oi.order_id

GROUP BY c.firstname ,
         c.lastname 

ORDER BY SUM(oi.quantity * oi.price) DESC 
LIMIT 1 ;
		 
######################################
#Afficher les 3 produits les plus vendus en termes de quantité totale.
SELECT p.product_id,p.name, SUM (ot.quantity)
FROM supershopanalytics.products p 
INNER JOIN supershopanalytics.orders_items ot
ON p.product_id = ot.product_id
GROUP BY p.product_id,p.name
ORDER BY SUM (ot.quantity) DESC
LIMIT 3;

###########################

Lister les commandes dont le montant total est strictement supérieur à la moyenne de toutes les commandes.

SELECT 
    p.order_id,
    p.order_date,
    SUM(oi.quantity * oi.price) AS total_commande
FROM supershopanalytics.orders p
INNER JOIN supershopanalytics.orders_items oi
       ON p.order_id = oi.order_id
GROUP BY p.order_id, p.order_date
HAVING SUM(oi.quantity * oi.price) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(quantity * price) AS total
        FROM supershopanalytics.orders_items
        GROUP BY order_id
    ) AS sous_totaux
)
ORDER BY total_commande DESC;


#################**Partie 7 – Statistiques & agrégats

########Calculer le chiffre d’affaires total (toutes commandes confondues, hors commandes annulées si souhaité).

SELECT
    oi.order_id,oi.product_id,
    SUM(oi.quantity * oi.price) AS "chiffre_affaires_total"
FROM supershopanalytics.orders_items oi
LEFT JOIN supershopanalytics.products p
       ON oi.product_id = p.product_id
LEFT JOIN supershopanalytics.orders o
       ON oi.order_id = o.order_id
GROUP BY oi.order_id,oi.product_id;

######################Calculer le panier moyen (montant moyen par commande).
SELECT 
    AVG(total_commande) AS panier_moyen
FROM (
    SELECT 
        SUM(oi.quantity * oi.price) AS total_commande
    FROM supershopanalytics.orders o
    INNER JOIN supershopanalytics.orders_items oi
           ON o.order_id = oi.order_id
    GROUP BY o.order_id
) AS totaux_par_commande;

##############################

#########Calculer la quantité totale vendue par catégorie.
SELECT  
    c.category_id, 
    c.name, 
    SUM(oi.quantity) AS quantite_totale
FROM supershopanalytics.categories c
INNER JOIN supershopanalytics.products p
    ON p.category_id = c.category_id
INNER JOIN supershopanalytics.orders_items oi
    ON oi.product_id = p.product_id
GROUP BY c.category_id, c.name
ORDER BY c.category_id;



########################
########Calculer le chiffre d’affaires par mois (au moins sur les données fournies).
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS annee,
    EXTRACT(MONTH FROM o.order_date) AS mois,
    SUM(oi.quantity * oi.price) AS chiffre_affaires
FROM supershopanalytics.orders o
INNER JOIN supershopanalytics.orders_items oi
    ON o.order_id = oi.order_id
GROUP BY 
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date)
ORDER BY 
    annee,
    mois;