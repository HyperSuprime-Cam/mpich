# EupsPkg config file. Sourced by 'eupspkg'

# If we're building on a cluster with PBS support, we check a few environment
# variables so we can make use of PBS installs into non-standard locations.
# In particular, if $PBS_DIR is set, we use $PBS_DIR/include and $PBS_DIR/lib
# for include and library paths, and otherwise check $PBS_INCLUDE_DIR and
# $PBS_LIB_DIR.  If none of these is set, and the user wants to use PBS, it
# needs to be in a standard search path (typically /usr or /usr/local).
#
# It isn't necessary to build against PBS, of course, on clusters that aren't
# using PBS.  It's also possible that PBS batch submission will work even
# without building mpich against the PBS libraries, if submission via rsh/ssh
# is supported on the cluster.
#
# We never *provide* PBS itself as a EUPS package, because it needs to be
# installed consistently on all nodes in a cluster, and that's well beyond the
# sort of thing we want to ask eups distrib to do.

if [ -n "${PBS_DIR:+x}" ]; then
    pbs_options+=" --with-pbs-include=$PBS_DIR/include --with-pbs-lib=$PBS_DIR/lib"
    LD_LIBRARY_PATH+=":$PBS_DIR/lib"
    DYLD_LIBRARY_PATH+=":$PBS_DIR/lib"
else
    if [ -n "${PBS_INCLUDE_DIR:+x}" ]; then
        pbs_options+=" --with-pbs-include=$PBS_INCLUDE_DIR"
    fi
    if [ -n "${PBS_LIB_DIR:+x}" ]; then
        pbs_options+=" --with-pbs-lib=$PBS_LIB_DIR"
        LD_LIBRARY_PATH+=":$PBS_LIB_DIR"
        DYLD_LIBRARY_PATH+=":$PBS_LIB_DIR"
    fi
fi

CONFIGURE_OPTIONS="--prefix=$PREFIX --enable-shared --disable-fortran $pbs_options"
