#!/bin/bash
# This script fetches the book "Mining of Massive Datasets" from http://www.mmds.org/.

# Create the directory that will contain the pdf-files.
DESTINATION_DIR="book_mining_of_massive_datasets"
rm -r -f $DESTINATION_DIR
mkdir $DESTINATION_DIR

# Fetch the Preface.
wget http://infolab.stanford.edu/~ullman/mmds/preface.pdf --directory-prefix=$DESTINATION_DIR
# Fetch the Index.
wget http://infolab.stanford.edu/~ullman/mmds/indexn.pdf --directory-prefix=$DESTINATION_DIR
# Fetch the chapters using a loop.
for CHAPTER in {1..13}
do
    # Note that some chapters have new versions. These have a "n" after the
    # chapter number. Currently the following chapters have a new version: 1, 2, 3, 10, 12.
    CHAPTER_URL="http://infolab.stanford.edu/~ullman/mmds/ch${CHAPTER}n.pdf"
    # Check if the new version is available.
    if wget --spider $CHAPTER_URL 2>/dev/null; then
        # New version exists. Keep the defined URL.
        echo "Download chapter ${CHAPTER}n ..."
    else
        # Currently there is only a version without the "n".
        echo "Download chapter ${CHAPTER} ..."
        CHAPTER_URL="http://infolab.stanford.edu/~ullman/mmds/ch${CHAPTER}.pdf"
    fi
    # Download.
    wget \
        $CHAPTER_URL \
        --directory-prefix=$DESTINATION_DIR
done