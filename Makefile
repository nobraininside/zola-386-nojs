# ====== Makefile blog.nicolabaudo.fr (Zola) ======

# Parametri personalizzabili
ZOLA        = /usr/local/bin/zola
SSH_PORT    = 52820
REMOTE_USER = jnasnoul
REMOTE_HOST = difesadigitale.xyz
REMOTE_PATH = /home/jnasnoul/public_html/blog.nicolabaudo.fr
BACKUP_DIR  = /home/jnasnoul/_zola_backup
PUBLIC_DIR  = public

# Target di default
all: build

# === Preview locale (sviluppo) ===
preview:
	@echo "Avvio server Zola su http://127.0.0.1:1111 ..."
	$(ZOLA) serve

# === Build: genera la cartella statica (./public) ===
build:
	@echo "Generazione del sito statico con Zola..."
	$(ZOLA) build
	@echo "Build completata in ./$(PUBLIC_DIR)"

# === Deploy remoto via SCP con backup ===
deploy: build
	@echo "Connessione a $(REMOTE_USER)@$(REMOTE_HOST) sulla porta $(SSH_PORT)..."
	@DATE=$$(date +%Y%m%d_%H%M%S); \
	echo "Creazione del backup remoto in $(BACKUP_DIR)/backup_$${DATE}.tar.gz"; \
	ssh -p $(SSH_PORT) $(REMOTE_USER)@$(REMOTE_HOST) "\
		mkdir -p $(BACKUP_DIR) && \
		cd $(REMOTE_PATH)/.. && \
		tar czf $(BACKUP_DIR)/backup_$${DATE}.tar.gz $$(basename $(REMOTE_PATH))"
	@echo "Pulizia della directory remota..."
	ssh -p $(SSH_PORT) $(REMOTE_USER)@$(REMOTE_HOST) "rm -rf $(REMOTE_PATH)/*"
	@echo "Caricamento dei nuovi file..."
	scp -P $(SSH_PORT) -r ./$(PUBLIC_DIR)/* $(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_PATH)/
	@echo "Deploy completato con successo."

# === Pulizia locale ===
clean:
	@echo "Rimozione della cartella $(PUBLIC_DIR) ..."
	rm -rf $(PUBLIC_DIR)
	@echo "Pulizia completata."

