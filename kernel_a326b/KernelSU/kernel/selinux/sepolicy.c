#include <linux/kernel.h>
#include "sepolicy.h"
int ksu_sepolicy_init(void) { return 0; }
void ksu_sepolicy_exit(void) {}
int ksu_sepolicy_load(void) { return 0; }
int ksu_sepolicy_add_rule(const char *rule) { return -ENOSYS; }
int ksu_sepolicy_rule_count(void) { return 0; }
