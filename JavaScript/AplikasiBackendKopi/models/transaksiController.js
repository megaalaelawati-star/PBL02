const pembeliController = {
    getAllPembeli: async (req, res, next) => {
        try {
            const pool = req.app.locals.pool;
            const [rows] = await pool.execute('SELECT * FROM pembeli ORDER BY created_at DESC');

            res.json({
                success: true,
                data: rows,
                total: rows.length
            });
        } catch (error) {
            next(error);
        }
    },

    getPembeliById: async (req, res, next) => {
        try {
            const pool = req.app.locals.pool;
            const [rows] = await pool.execute(
                'SELECT * FROM pembeli WHERE id = ?',
                [req.params.id]
            );

            if (rows.length === 0) {
                return res.status(404).json({
                    success: false,
                    message: 'Pembeli tidak ditemukan'
                });
            }

            res.json({
                success: true,
                data: rows[0]
            });
        } catch (error) {
            next(error);
        }
    },

    createPembeli: async (req, res, next) => {
        try {
            const { nama, email, telepon, alamat } = req.body;
            const pool = req.app.locals.pool;

            const [result] = await pool.execute(
                'INSERT INTO pembeli (nama, email, telepon, alamat) VALUES (?, ?, ?, ?)',
                [nama, email, telepon, alamat]
            );

            res.status(201).json({
                success: true,
                message: 'Pembeli berhasil ditambahkan',
                data: {
                    id: result.insertId,
                    nama,
                    email,
                    telepon,
                    alamat
                }
            });
        } catch (error) {
            if (error.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({
                    success: false,
                    message: 'Email sudah terdaftar'
                });
            }
            next(error);
        }
    }
};

module.exports = pembeliController;