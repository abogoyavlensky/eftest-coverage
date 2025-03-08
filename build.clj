(ns build
  (:require [clojure.tools.build.api :as b]
            [deps-deploy.deps-deploy :as dd]))

(def lib 'abogoyavlensky/eftest-coverage)
(def VERSION "0.1.12-SNAPSHOT")
(def class-dir "target/classes")


(defn- jar-opts [opts]
  (assoc opts
          :lib lib :version VERSION
          :jar-file (format "target/%s-%s.jar" lib VERSION)
          :scm {:tag VERSION}
          :basis (b/create-basis {})
          :class-dir class-dir
          :target "target"
          :src-dirs ["src"]
          :src-pom "template/pom.xml"))

(defn ci "Run the CI pipeline of tests (and build the JAR)." [opts]
  (b/delete {:path "target"})
  (let [opts (jar-opts opts)]
    (println "\nWriting pom.xml...")
    (b/write-pom opts)
    (println "\nCopying source...")
    (b/copy-dir {:src-dirs ["resources" "src"] :target-dir class-dir})
    (println "\nBuilding" (:jar-file opts) "...")
    (b/jar opts))
  opts)

(defn deploy "Deploy the JAR to Clojars." [opts]
  (let [{:keys [jar-file] :as opts} (jar-opts opts)]
    (ci opts)
    (dd/deploy {:installer :remote :artifact (b/resolve-path jar-file)
                :pom-file (b/pom-path (select-keys opts [:lib :class-dir]))}))
  opts)
