const Bookmark = require('../models/Bookmark');


module.exports = {
    createBookmark: async (req, res) => {
        const newBookmark = new Bookmark(req.body);

        try {
            const createdBookmark = await newBookmark.save();
            const { __v, createdAt, updatedAt, ...newBookmarkInfo } = createdBookmark._doc;

            res.status(200).json(newBookmarkInfo);
        } catch (error) {
            res.status(500).json(error);
        }
    },
    updateBookmark: async (req, res) => {
        try {
            const updatedBookmark = await Bookmark.findByIdAndUpdate(
                req.params.id, {
                $set: req.body
            }, { new: true }
            );
            const { __v, createdAt, updatedAt, ...bookmarkData } = updatedBookmark._doc

            res.status(200).json(bookmarkData);
        } catch (error) {
            res.status(500).json(error);
        }

    },
    deleteBookmark: async (req, res) => {
        try {
            await Bookmark.findByIdAndDelete(req.params.id)

            res.status(200).json("Bookmark Success Delete.");

        } catch (error) {
            res.status(500).json(error);
        }
    }
    ,
    getBookmark: async (req, res) => {
        try {
            const bookmark = await Bookmark.findById(req.params.id)
            const {  __v, createdAt, updatedAt, ...bookmarkData } = bookmark._doc

            res.status(200).json(bookmarkData);

        } catch (error) {
            res.status(500).json(error);
        }
    },
    getAllBookmark: async (req, res) => {
        try {
            const bookmarks = await Bookmark.find();
            console.log(bookmarks);
            res.status(200).json(bookmarks);

        } catch (error) {
            res.status(500).json(error);
        }
    },
    searchBookmarks: async (req, res) => {
        try {
            const bookmarks = await Bookmark.aggregate(
                [
                    {
                        $search: {
                            index: "bookmarksearch",
                            text: {
                                query: req.params.key,
                                path: {
                                    wildcard: "*"
                                }
                            }
                        }
                    }
                ]
            );
            console.log(bookmarks);
            res.status(200).json(bookmarks);

        } catch (error) {
            res.status(500).json(error);
        }
    }

}
