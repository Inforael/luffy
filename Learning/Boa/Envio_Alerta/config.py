# Configuration goes here:
RESOURCE = "https://analysis.windows.net/powerbi/api"							# Don't change that.
MICROSOFT_TOKEN = "https://login.microsoftonline.com/common/oauth2/token"		# Don't change that.

APPLICATION_ID = "379a9fcb-7cfc-40a6-857e-8b2b24e6a55d"							# É a ID do aplicativo (cliente) relativa ao aplicativo registrado no portal do Azure. 
																				# Você pode encontrar esse valor na página Visão Geral do aplicativo no portal do Azure.

APPLICATION_SECRET = "1_-1FeX4-g90H2t-YfyK48HMgOZ8J3Fh2-"						# É o segredo do cliente criado para o aplicativo no portal do Azure. Expira em 12 meses

USER_ID = "weduu.retail@services.weduuretail.com"								# Usuário de acesso da aplicação Power BI
USER_PASSWORD = "WedRe@71965"													    # password do usuário

GROUP_ID   = 'b667a3e1-6a44-424a-ad72-3ad5f6fbdab2'							   # O id do workspace que contém o relatório que você deseja incorporar (https://app.powerbi.com/groups/{GROUP_ID}/list/dashboards)

DATASET_ID_DQ = ['DATA QUALITY', 'fed5dfa9-d0f6-449a-8011-93bea10f182a']		    # A id do dataset que você deseja atualizar (https://app.powerbi.com/groups/{GROUP_ID}/settings/datasets/{DATASET_ID})
DATASET_ID_PI = ['PAINEL DE INDICADORES', '19e49726-01e2-46c2-a2a6-de1ab12410e1']	# A id do dataset que você deseja atualizar (https://app.powerbi.com/groups/{GROUP_ID}/settings/datasets/{DATASET_ID})
DATASET_ID_PV = ['PREVISÃO VENDAS','20a2a28f-0f31-4629-b045-ab04dee4ba62']			# A id do dataset que você deseja atualizar (https://app.powerbi.com/groups/{GROUP_ID}/settings/datasets/{DATASET_ID})

#DATASET_ID_PV,

DATASETS_LIST = [DATASET_ID_DQ, DATASET_ID_PI]

# Email Configuration

EMISSOR             = "customer@services.weduu.com"
PASS_EMISSOR        = "Mq>d2SPn"
RECEBEDOR           = ["sustentacao.bi@netpartners.com.br",	"simone.yamaguti@weduu.com"]
ASSUNTO_EMAIL       = "Power Bi Boa 'STATUS REPORT'"
