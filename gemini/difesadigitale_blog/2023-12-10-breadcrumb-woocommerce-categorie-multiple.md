---
Title: Breadcrumb Woocommerce categorie multiple
Published: 2023-12-10 13:16:17
Author: yellowadmin
Layout: blog
Tag: wordpress
---
Quando si hanno molteplici categorie prodotto in un e-commerce Woocommerce-Wordpress, la funzione nativa *breadcrumb* può mostrare percorsi aleatori. Se vuoi che il percorso mostrato di un dato prodotto sia sempre lo stesso, devi aggiungere un po' di codice. È molto facile: vediamo come.

 1) collegati all'hosting del tuo sito e vai al pannello amministrazione. Individua l'icona che apre il file manager e vai a `public_html/lemmapress.com/wp-content/plugins/woocommerce/templates/global`

2) individua il file *breadcrumb.php* e per prima cosa duplicalo (per esempio: clic destro sul file > copy > salva come breadcrumb.php-BAK)
[--more--]<br />
3) apri *breadcrumb.php* e individua la riga `if ( ! empty( $breadcrumb ) ) {`

4) sotto quella riga inserisci il codice seguente, come suggerito [qui](https://wordpress.org/support/topic/breadcrumbs-for-products-in-multiple-categories/):

```
	if( is_product() ) {
		$permalinks = wc_get_permalink_structure();
		$current_title = end($breadcrumb)[0];
		if ( $_SERVER['HTTP_REFERER'] ) {
			$url_parts = explode( '/', trim( wp_parse_url( $_SERVER['HTTP_REFERER'] )['path'], '/' ) );
			$url = site_url() . '/' . $permalinks['category_base'];
			$breadcrumb = array(
				array( __( 'Homepage', 'woocommerce-multilingual' ), site_url(), ),
				array( __( 'Catalog', 'woocommerce' ), site_url() . $permalinks['product_base'] . '/', ),
			);
			foreach( $url_parts as $url_part ) {
				if( $term = get_term_by( 'slug', $url_part, 'product_cat' ) ) {
					$url .= '/' . $url_part;
					$breadcrumb[] = array( $term->name, $url );
				}
			}
			$breadcrumb[] = array( $current_title );
		} else {
			$breadcrumb = array(
				array( __( 'Homepage', 'woocommerce-multilingual' ), site_url(), ),
				array( __( 'Products', 'woocommerce-multilingual' ), site_url() . $permalinks['product_base'] . '/', ),
				array( $current_title ),
			);
		}
	}
```

5) Eventualmente modifica le intestazioni *Homepage* e *Catalog* con qualcosa adatto ai tuoi bisogni (per esempio, se vendi libri, sostituisci rispettivamente con *Home* e *Bookshop*. Salva. Fine!
