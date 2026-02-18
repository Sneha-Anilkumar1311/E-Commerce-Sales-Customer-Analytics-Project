-- ============================================
-- ECOMMERCE SQL ANALYTICS PROJECT
-- Description: SQL analysis for revenue, customers and products
-- ============================================


-- ============================================
-- 1 TOTAL REVENUE
-- ============================================

SELECT
    SUM(quantity * price) AS total_revenue
FROM order_items;



-- ============================================
-- 2 REVENUE BY PRODUCT
-- ============================================

SELECT
    p.product_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;



-- ============================================
-- 3 TOP CUSTOMERS BY REVENUE
-- ============================================

SELECT
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;



-- ============================================
-- 4 NUMBER OF ORDERS PER CUSTOMER
-- ============================================

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;



-- ============================================
-- 5 RFM BASE CALCULATION
-- ============================================

SELECT
    c.customer_id,
    c.customer_name,
    MAX(o.order_date) AS last_order_date,
    COUNT(o.order_id) AS frequency,
    SUM(oi.quantity * oi.price) AS monetary
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY monetary DESC;
