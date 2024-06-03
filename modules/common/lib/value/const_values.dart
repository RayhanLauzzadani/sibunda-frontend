class Const {
  Const._();

  static const ENV = "env";

  static const HEADER_AUTH = "Authorization";

  static const SEPARATOR_ANSWER_ITEM = ";~;";

  static const KEY_CTX = "context";
  static const KEY_ONLY_SINGLE_PAGE = "only_single_page";

  static const REMOTE_HOST = "https://sibunda3.digitalise.biz.id";
  static const ENDPOINT_ROOT = "$REMOTE_HOST/api";
  static const ENDPOINT_AUTH = "$ENDPOINT_ROOT/auth";
  static const ENDPOINT_PREGNANCY = "$ENDPOINT_ROOT/kehamilanku";
  static const ENDPOINT_BABY = "$ENDPOINT_ROOT/anaku";
  static const ENDPOINT_DATA = "$ENDPOINT_ROOT/data";
  static const ENDPOINT_COVID = "$ENDPOINT_ROOT/covid";
  static const ENDPOINT_HOME = "$ENDPOINT_ROOT/dashboard";

  static const CLIENT_SECRET = "5xnEHfLiRiyyRGrez97iEmqzTB4h48IWr5DnHEuO";
  static const CLIENT_ID = 2;
  static const DUMMY_FCM_TOKEN = "ini token";
  static const FCM_WEB_PUSH_CERT =
      "BBw65v7mrdPsVwq8YRZWrDVtBkmG0hVyAt7B8zmeK1iFvMBDaSsDaydTiX0LEFMTgFYQTR1kYbOfcXIbZqRzKAA";

  static const GENDER_MALE = "M";
  static const GENDER_FEMALE = "F";

  static const CODE_OK = 0;
  static const CODE_NOT_OK = -1;

  static const KEY_ID = "id";
  static const KEY_DATA = "data";
  static const KEY_PREGNANCY_ID = "pregnancy_id";
  static const KEY_IS_EDIT = "is_edit";
  static const KEY_LOAD_LAST = "load_last"; // type bool
  static const KEY_IS_LAST_TRIMESTER = "is_last_trimester"; // type bool
  static const KEY_IMG = "img";
  static const KEY_IMG_URL = "img_url";
  static const KEY_PIC = "pic";
  static const KEY_ACCESS_TOKEN = "access_token";
  static const KEY_FCM_TOKEN = "fcm_token";
  static const KEY_NAME = "name";
  static const KEY_NAME_INDO = "nama";
  static const KEY_EMAIL = "email";
  static const KEY_OLD_PSWD = "old_password";
  static const KEY_PSWD = "password";
  static const KEY_RE_PSWD = "password_confirmation";
  static const KEY_NAME_CLIENT = "user_name";
  static const KEY_CLIENT_ID = "client_id";
  static const KEY_CLIENT_SECRET = "client_secret";
  static const KEY_SESSION = "_session_";
  static const KEY_ACTIVE_EMAIL = "_active_email_";
  static const KEY_CAN_SKIP = "can_skip";
  static const KEY_PROFILE = "profile";
  static const KEY_CREDENTIAL = "credential";

  static const KEY_USER_GROUP_ID = "user_group_id";
  static const KEY_TOKEN_TYPE = "token_type";

  static const KEY_CHILD = "anak";
  static const KEY_TRIMESTER = "trimester";
  static const KEY_NIK = "nik";
  static const KEY_JKN = "no_jkn";
  static const KEY_FASKES1 = "faskes_tk1";
  static const KEY_FASKES_RUJUKAN = "faskes_rujukan";
  static const KEY_SALARY = "pembiayaan";
  static const KEY_BLOOD_TYPE = "gol_darah";
  static const KEY_BIRTH_PLACE = "tempat_lahir";
  static const KEY_BIRTH_DATE = "tanggal_lahir";
  static const KEY_EDUCATION = "pendidikan";
  static const KEY_OCCUPANCY = "pekerjaan";
  static const KEY_ADDRESS = "alamat_rumah";
  static const KEY_PHONE = "telp";
  static const KEY_PUSKESMAS_DOMISILI = "puskesmas_domisili";

  static const KEY_COHORT_REG = "nomor_register_kohort_ibu";

  static const KEY_BABY_COHORT_REG =
      "no_kohort"; //"nomor_register_kohort_bayi";
  static const KEY_TODDLER_COHORT_REG = "nomor_register_kohort_balita";
  static const KEY_CHILD_ORDER = "anak_ke";
  static const KEY_GENDER = "kelamin";
  static const KEY_BIRTH_CERT_NO = "no_akte_kelahiran";
  static const KEY_JKN_START_DATE = "tanggal_berlaku_jkn";
  static const KEY_HOSPITAL_MEDIC_NO = "no_catatan_medik";

  static const KEY_DATE = "date";
  static const KEY_PLACE = "location";
  static const KEY_AGE = "age";

  static const KEY_BABY_NAME = "nama_bayi";
  static const KEY_VISIT_DATE = "tanggal_periksa";
  static const KEY_VISIT_PLACE = "tempat_periksa";
  static const KEY_CHECKER_NAME = "nama_pemeriksa";
  static const KEY_CHECKER = "pemeriksa";
  static const KEY_MOTHER_DIFFICULTY = "keluhan_bunda";
  static const KEY_PREGNANCY_AGE = "usia_kehamilan";
  static const KEY_BABY_GENDER = "jenis_kelamin"; //"kelamin_bayi";
  static const KEY_FUTURE_VISIT_DATE = "tanggal_periksa_kembali";
  static const KEY_HPHT = "hpht";
  static const KEY_HPL = "hpl";
  static const KEY_WEIGHT = "bb"; //"berat_badan_bunda";
  static const KEY_WEIGHT_DIFF = "kenaikan_bb"; //"kenaikan_berat_badan_bunda";
  static const KEY_HEIGHT = "tb"; //"tinggi_badan_bunda";
  static const KEY_TFU = "tfu";
  static const KEY_DJJ = "djj";
  static const KEY_SYSTOLIC_PRESSURE = "sistolik";
  static const KEY_DIASTOLIC_PRESSURE = "diastolik";
  static const KEY_MAP = "map";
  static const KEY_BABY_MOVEMENT = "gerakan_bayi";
  static const KEY_DRUG_PRESCRIPT = "resep_obat";
  static const KEY_DRUG_ALLERGY = "alergi_obat";
  static const KEY_DISEASE_HISTORY = "riwayat_penyakit";
  static const KEY_SPECIAL_NOTE = "catatan_khusus";
  static const KEY_IMG_USG = "img_usg";

  static const KEY_CURRENT_PREGNANCY_ID = "current_preg_id";

  static const KEY_REM_DAYS = "remaining_days";
  static const KEY_FOOD_RECOM = "food_recommendations";
  static const KEY_TRIMESTERS = "trisemesters";
  static const KEY_TRIMESTER_NO = "trisemester";
  static const KEY_TRIMESTER_ID = "trisemester_id";
  static const KEY_BABY_ID = "kia_anak_id";
  static const KEY_FOOD_CATEGORY = "food_category";
  static const KEY_FOOD_DESC = "food_dose";
  static const KEY_WEEK = "week";
  static const KEY_MONTH = "month";

  static const KEY_PREGNANCY_CHECKUP_ID = "weekly_trisemester_checkup_id";

  static const KEY_FETUS_GROWTH_DESC = "fetus_growth_desc";
  static const KEY_WEIGHT_DESC = "weight_desc";
  static const KEY_MOM_PULSE_DESC = "mom_pulse_desc";
  static const KEY_TFU_DESC = "tfu_desc";
  static const KEY_DJJ_DESC = "djj_desc";
  static const KEY_BABY_MOVEMENT_DESC = "baby_movement_desc";

  static const KEY_IMMUNIZATION_ID = "immunization_id";

  static const KEY_BOTTOM_THRESHOLD = "bottom_threshold";
  static const KEY_NORMAL_THRESHOLD = "normal_threshold";
  static const KEY_TOP_THRESHOLD = "top_threshold";
  static const KEY_BOTTOM_OBESITY_THRESHOLD = "bottom_obesity_threshold";
  static const KEY_BOTTOM_OVER_THRESHOLD = "bottom_over_threshold";
  static const KEY_BOTTOM_NORMAL_THRESHOLD = "bottom_normal_threshold";

  static const KEY_IS_NORMAL = "is_normal";
  static const KEY_HEAD_CIRCUM = "lingkar_kepala";
  static const KEY_IMT = "imt";
  static const KEY_YEAR_ID = "year_id";

  //static const KEY_q_imd = "q_imd";

  static const KEY_Q_IMD = "q_imd";
  static const KEY_Q_VIT_K1 = "q_vit_k1";
  static const KEY_Q_SALEP = "q_salep";
  static const KEY_Q_IMUNISASI_HB = "q_imunisasi_hb";
  //static const KEY_DATE = "date";
  static const KEY_TIME = "time";
  //static const KEY_NO_BATCH = "no_batch";
  static const KEY_DIRUJUK_KE = "dirujuk_ke";
  static const KEY_PETUGAS = "petugas";
  static const KEY_CATATAN_PENTING = "catatan_penting";

  static const KEY_INPUT = "input";
  static const KEY_PERKEMBANGAN_ANS = 'perkembangan_ans';

  static const KEY_IMMUNIZATION_DATE = "tanggal_imunisasi";
  static const KEY_IMMUNIZATION_PLACE = "tempat_imunisasi";
  static const KEY_RESPONSIBLE_NAME = "nama_penanggungjawab";
  static const KEY_NO_BATCH = "no_batch";
}
