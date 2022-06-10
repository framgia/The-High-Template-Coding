import org.w3c.dom.Element
import org.w3c.dom.Node
import java.io.PrintWriter
import java.util.*
import javax.xml.parsers.DocumentBuilderFactory
import kotlin.collections.HashMap

enum class DimenType {
    /**
     * Best for auto generate the dimension by the default values/dimens.xml file.
     */
    FROM_DIMEN_FILE,

    /**
     * Best for auto generate the dimension as default.
     */
    AUTO_CREATE
}

open class DimenFactory : DefaultTask() {

    @Input
    private val dimens = listOf(
        320,
        360,
        384,
        411,
        480,
        540,
        600,
        720,
        800,
        960,
        1024,
        1080,
        1280,
        1440,
        2560,
        3840
    )

    @Input
    private val baseDimen = 360

    @Input
    private val positiveMaxDP = 500

    @Input
    private val positiveMaxSP = 60

    @Input
    private val negativeMaxDP = 180

    @Input
    private val type = DimenType.FROM_DIMEN_FILE

    @Input
    private val dimenFileName = "values/dimens.xml"

    private val resFolder = project.projectDir.path + "/src/main/res/"

    @TaskAction
    fun create() {
        when (type) {
            DimenType.AUTO_CREATE -> autoCreateDimen()
            DimenType.FROM_DIMEN_FILE -> createDimenFromDimenFile()
        }
    }

    private fun createDimenFromDimenFile() {
        println("Start convert dimen from value file to other screen size")
        val path = resFolder + dimenFileName
        val pairs = HashMap<String, String>()
        try {
            val fXmlFile = File(path)
            val dbFactory = DocumentBuilderFactory.newInstance()
            val dBuilder = dbFactory.newDocumentBuilder()
            val doc = dBuilder.parse(fXmlFile)
            doc.documentElement.normalize()

            val nList = doc.getElementsByTagName("dimen")
            for (i in 0 until nList.length) {
                val nNode = nList.item(i)
                if (nNode.nodeType == Node.ELEMENT_NODE) {
                    val eElement = nNode as Element
                    if (eElement.textContent.contains("@dimen")) continue
                    pairs[eElement.getAttribute("name")] = eElement.textContent
                }
            }
            val dps = HashMap<String, Double>()
            val sps = HashMap<String, Double>()

            for (entry in pairs) {
                val value = entry.value.replace("dp", "").replace("sp", "").toDouble()
                if (entry.value.contains("dp")) {
                    dps[entry.key] = value
                } else {
                    sps[entry.key] = value
                }
            }
            //Sort
            val sortedDps = TreeMap(dps)
            val sortedSps = TreeMap(sps)
            for (dimen in dimens) {
                val folder = resFolder + "values-sw" + dimen + "dp"
                val fileName = "$folder/auto_dimens.xml"
                File(folder).mkdir()
                File(fileName).createNewFile()
                val printWriter = PrintWriter(fileName)
                printWriter.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>")
                printWriter.println("<resources>")
                for (entry in sortedDps) {
                    val ratio = dimen / baseDimen
                    val dp = ratio * entry.value
                    printWriter.printf(
                        "\t<dimen name=\"%s\">%.2fdp</dimen>\r\n",
                        entry.key,
                        dp
                    )
                }
                printWriter.println()
                for (entry in sortedSps) {
                    val ratio = dimen / baseDimen
                    val sp = ratio * entry.value
                    printWriter.printf(
                        "\t<dimen name=\"%s\">%.2fsp</dimen>\r\n",
                        entry.key,
                        sp
                    )
                }
                printWriter.println("</resources>")
                printWriter.close()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun autoCreateDimen() {
        // write dimen.xml
        val defaultFolder = resFolder + "values"
        val defaultDimensFile = "$defaultFolder/dimens.xml"
        File(defaultFolder).mkdir()
        File(defaultDimensFile).createNewFile()
        writeAutoDimen(defaultDimensFile, baseDimen)

        // write other auto_dimens.xml
        for (dimen in dimens) {
            val folder = resFolder + "values-sw" + dimen + "dp"
            val fileName = "$folder/auto_dimens.xml"
            File(folder).mkdir()
            File(fileName).createNewFile()
            writeAutoDimen(fileName, dimen)
        }
    }

    private fun writeAutoDimen(fileName: String, dimen: Int) {
        println("Auto create dimension file and values $fileName")
        PrintWriter(fileName).run {
            println("<?xml version=\"1.0\" encoding=\"utf-8\"?>")
            println("<resources>")
            printPositiveDP(dimen)
            println()
            printNegativeDP(dimen)
            println()
            printPositiveSP(dimen)
            println("</resources>")
            close()
        }
    }

    private fun PrintWriter.printPositiveDP(dimen: Int) {
        val ratio = dimen / baseDimen.toFloat()
        for (i in 1..positiveMaxDP) {
            printDimen(i, ratio, "dp")
        }
    }

    private fun PrintWriter.printNegativeDP(dimen: Int) {
        val ratio = dimen / baseDimen.toFloat()
        for (i in 1..negativeMaxDP) {
            printDimen(i, ratio, "dp", true)
        }
    }

    private fun PrintWriter.printPositiveSP(dimen: Int) {
        val ratio = dimen / baseDimen.toFloat()
        for (i in 1..positiveMaxSP) {
            printDimen(i, ratio, "sp")
        }
    }

    private fun PrintWriter.printDimen(
        index: Int,
        ratio: Float,
        unit: String,
        isNegative: Boolean = false
    ) {
        val indexName = if (isNegative) "${unit}_minus" else unit
        val value = if (isNegative) -ratio * index else ratio * index
        val format = "\t<dimen name=\"${indexName}_%d\">%.2f$unit</dimen>\r\n"
        printf(format, index, value)
    }
}

tasks.register("createDimen", DimenFactory::class) {
    create()
}
