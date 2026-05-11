// SPDX-License-Identifier: GPL-2.0
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/fdtable.h>
#include <linux/file.h>
#include <linux/fsnotify.h>
#include <linux/mount.h>
#include <linux/namei.h>
#include <linux/poll.h>
#include <linux/security.h>
#include <linux/slab.h>
#include <linux/xattr.h>
#include <linux/fs_stack.h>
#include <linux/magic.h>
#include <linux/compat.h>
#include <linux/syscalls.h>
#include <linux/proc_fs.h>
#include <linux/fcntl.h>
#include <linux/capability.h>
#include <linux/sched/signal.h>
#include <linux/sched/task.h>
#include <linux/sched/mm.h>
#include <linux/mm.h>
#include <linux/mman.h>
#include <linux/uio.h>
#include <linux/buffer_head.h>
#include <linux/suspend.h>
#include <linux/exportfs.h>
#include <linux/blkdev.h>
#include <linux/backing-dev.h>
#include <linux/pagevec.h>
#include <linux/writeback.h>
#include <linux/quotaops.h>
#include <linux/err.h>
#include <linux/kallsyms.h>
#include <linux/module.h>
#include <linux/version.h>
#include "../include/ksu.h"

struct ksu_file_wrapper {
	struct file *orig;
};

static void ksu_release_file_wrapper(struct ksu_file_wrapper *data)
{
	if (data) {
		if (data->orig)
			fput(data->orig);
		kfree(data);
	}
}

// Stub out all VFS hooks that don't exist in kernel 4.14
static int ksu_wrapper_iopoll(struct kiocb *kiocb, bool spin) { return -EOPNOTSUPP; }
static unsigned int ksu_wrapper_poll(struct file *fp, struct poll_table_struct *pts) { return 0; }
static loff_t ksu_wrapper_remap_file_range(struct file *file_in, loff_t pos_in, struct file *file_out, loff_t pos_out, loff_t len, unsigned int remap_flags) { return -EOPNOTSUPP; }
static int ksu_wrapper_fadvise(struct file *fp, loff_t off1, loff_t off2, int flags) { return -EOPNOTSUPP; }
static int ksu_wrapper_iterate(struct file *fp, struct dir_context *dc) { return -EOPNOTSUPP; }
static int ksu_wrapper_iterate_shared(struct file *fp, struct dir_context *dc) { return -EOPNOTSUPP; }

static struct file_operations ksu_wrapper_fops = {
	// Only include ops that exist in kernel 4.14
	.open = NULL,
	.release = NULL,
	.llseek = NULL,
	.read = NULL,
	.write = NULL,
	.read_iter = NULL,
	.write_iter = NULL,
	.iterate = NULL,
	.poll = ksu_wrapper_poll,
	.unlocked_ioctl = NULL,
	.compat_ioctl = NULL,
	.mmap = NULL,
	.fsync = NULL,
	.fasync = NULL,
	.lock = NULL,
	.flush = NULL,
	.fallocate = NULL,
};

struct file *ksu_wrap_file(struct file *orig)
{
	struct ksu_file_wrapper *data;
	struct file *wrapper;

	if (!orig)
		return NULL;

	data = kzalloc(sizeof(*data), GFP_KERNEL);
	if (!data)
		return NULL;

	wrapper = alloc_file_pseudo(NULL, orig->f_path.mnt, orig->f_path.dentry->d_name.name, orig->f_flags, &ksu_wrapper_fops);
	if (!wrapper) {
		kfree(data);
		return NULL;
	}

	data->orig = orig;
	get_file(orig);
	wrapper->private_data = data;
	wrapper->f_op = &ksu_wrapper_fops;
	wrapper->f_mode = orig->f_mode;
	wrapper->f_flags = orig->f_flags;
	wrapper->f_pos = orig->f_pos;
	wrapper->f_inode = orig->f_inode;

	return wrapper;
}

void ksu_unwrap_file(struct file *wrapper)
{
	struct ksu_file_wrapper *data;

	if (!wrapper || !wrapper->private_data)
		return;

	data = wrapper->private_data;
	ksu_release_file_wrapper(data);
}
